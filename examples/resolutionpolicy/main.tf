data "azurerm_client_config" "current" {}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
}

# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = module.naming.resource_group.name_unique
}

# create first sample virtual network
module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.9.1"

  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.avmrg.location
  resource_group_name = azurerm_resource_group.avmrg.name
  enable_telemetry    = local.enable_telemetry
  name                = module.naming.virtual_network.name
  retry = {
    error_message_regex = ["CannotDeleteResource"]
    attempts            = 3
    delay               = "10s"
  }
  subnets = {
    subnet1 = {
      name           = "subnet1"
      address_prefix = "10.0.1.0/24"
    }
  }
  timeouts = {
    create = "5m"
    update = "5m"
    delete = "5m"
  }
}

# reference the module and pass in variables as needed
module "private_dns_zone" {
  # replace source with the correct link to the private_dns_zone module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"
  source = "../../"

  domain_name           = local.domain_name
  parent_id             = local.parent_id
  enable_telemetry      = local.enable_telemetry
  tags                  = local.tags
  virtual_network_links = local.virtual_network_links
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
      subnet_resource_id            = module.vnet.subnets["subnet1"].resource_id
      subresource_name              = "blob"
      private_dns_zone_resource_ids = [module.private_dns_zone.resource_id]
    }
  }
  role_assignments = {
    role_assignment_1 = {
      role_definition_id_or_name       = "Storage Blob Data Owner"
      principal_id                     = data.azurerm_client_config.current.object_id
      principal_type                   = "ServicePrincipal"
      skip_service_principal_aad_check = false
    }
  }
  tags = local.tags
}
