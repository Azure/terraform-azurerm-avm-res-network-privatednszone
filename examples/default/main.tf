data "azurerm_client_config" "current" {}

# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg-default-test"
}

# create first sample virtual network
module "vnet1" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.9.1"

  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.avmrg.location
  resource_group_name = azurerm_resource_group.avmrg.name
  enable_telemetry    = local.enable_telemetry
  name                = "vnet1"
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


# create second sample virtual network
module "vnet2" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.9.1"

  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.avmrg.location
  resource_group_name = azurerm_resource_group.avmrg.name
  enable_telemetry    = local.enable_telemetry
  name                = "vnet2"
  retry = {
    error_message_regex = ["CannotDeleteResource"]
    attempts            = 3
    delay               = "10s"
  }
  subnets = {
    subnet2 = {
      name           = "subnet2"
      address_prefix = "10.1.1.0/24"
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

  domain_name      = local.domain_name
  parent_id        = local.parent_id
  a_records        = local.a_records
  aaaa_records     = local.aaaa_records
  cname_records    = local.cname_records
  enable_telemetry = local.enable_telemetry
  mx_records       = local.mx_records
  ptr_records      = local.ptr_records
  retry = {
    error_message_regex = ["CannotDeleteResource"]
    attempts            = 3
    delay               = "10s"
  }
  role_assignments = local.role_assignments
  soa_record       = local.soa_record
  srv_records      = local.srv_records
  tags             = local.tags
  timeouts = {
    dns_zones = {
      create = "50m"
      delete = "50m"
      read   = "10m"
      update = "50m"
    }
    vnet_links = {
      create = "50m"
      delete = "50m"
      read   = "10m"
      update = "50m"
    }
  }
  txt_records           = local.txt_records
  virtual_network_links = local.virtual_network_links
}
