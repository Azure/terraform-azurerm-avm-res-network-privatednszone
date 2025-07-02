data "azurerm_client_config" "current" {}

# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg"
}

# create first sample virtual network
resource "azurerm_virtual_network" "vnet1" {
  location            = azurerm_resource_group.avmrg.location
  name                = "vnet1"
  resource_group_name = azurerm_resource_group.avmrg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    address_prefixes = ["10.0.1.0/24"]
    name             = "subnet1"
  }
}

# reference the module and pass in variables as needed
module "private_link_dns_zone" {
  # replace source with the correct link to the private_link_dns_zone module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"
  source = "../../"

  domain_name           = local.domain_name
  parent_id             = local.parent_id
  enable_telemetry      = local.enable_telemetry
  tags                  = local.tags
  virtual_network_links = local.virtual_network_links
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.3.0"
}

module "avm_storageaccount" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.5.0"

  location            = azurerm_resource_group.avmrg.location
  name                = module.naming.storage_account.name_unique
  resource_group_name = azurerm_resource_group.avmrg.name
  private_endpoints = {
    private_endpoint_1 = {
      name                          = module.naming.private_endpoint.name_unique
      subnet_resource_id            = "${azurerm_virtual_network.vnet1.id}/subnets/subnet1"
      subresource_name              = "blob"
      private_dns_zone_resource_ids = [module.private_link_dns_zone.resource_id]
    }
  }
  tags = local.tags
}
