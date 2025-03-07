# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg"
}

# create first sample virtual network
resource "azurerm_virtual_network" "vnet1" {
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.avmrg.location
  name                = "vnet1"
  resource_group_name = azurerm_resource_group.avmrg.name

  subnet {
    address_prefixes = ["10.0.1.0/24"]
    name             = "subnet1"
  }
}

# create second sample virtual network
resource "azurerm_virtual_network" "vnet2" {
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.avmrg.location
  name                = "vnet2"
  resource_group_name = azurerm_resource_group.avmrg.name

  subnet {
    address_prefixes = ["10.1.1.0/24"]
    name             = "subnet2"
  }
}

# create app registration
resource "azuread_application" "this" {
  display_name = "dnszonecontributor"
}

# create service principal from app
resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id
}


# reference the module and pass in variables as needed
module "private_dns_zones" {
  # replace source with the correct link to the private_dns_zones module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"  
  source                = "../../"
  enable_telemetry      = local.enable_telemetry
  resource_group_name   = azurerm_resource_group.avmrg.name
  domain_name           = local.domain_name
  tags                  = local.tags
  soa_record            = local.soa_record
  virtual_network_links = local.virtual_network_links
  a_records             = local.a_records
  aaaa_records          = local.aaaa_records
  cname_records         = local.cname_records
  mx_records            = local.mx_records
  ptr_records           = local.ptr_records
  srv_records           = local.srv_records
  txt_records           = local.txt_records
  role_assignments      = local.role_assignments
}
