# create the resource group
resource "azurerm_resource_group" "avmrg" {
  name     = "avmrg"
  location = "EastUS"
}

# create first sample virtual network
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = azurerm_resource_group.avmrg.location
  resource_group_name = azurerm_resource_group.avmrg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
}

# create second sample virtual network
resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  location            = azurerm_resource_group.avmrg.location
  resource_group_name = azurerm_resource_group.avmrg.name
  address_space       = ["10.1.0.0/16"]

  subnet {
    name           = "subnet2"
    address_prefix = "10.1.1.0/24"
  }
}

# reference the module and pass in variables as needed
module "private_dns_zones" {
  # replace source with the correct link to the private_dns_zones module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"  
  source                = "../../"
  enable_telemetry      = local.enable_telemetry
  resource_group_name   = azurerm_resource_group.avmrg.name
  domain_name           = local.domain_name
  dns_zone_tags         = local.dns_zone_tags
  soa_record            = local.soa_record
  virtual_network_links = local.virtual_network_links
  a_records             = local.a_records
  aaaa_records          = local.aaaa_records
  cname_records         = local.cname_records
  mx_records            = local.mx_records
  ptr_records           = local.ptr_records
  srv_records           = local.srv_records
  txt_records           = local.txt_records
}