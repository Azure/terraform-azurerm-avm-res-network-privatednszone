terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0, < 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

data "azurerm_client_config" "current" {}

module "regions" {
  source  = "Azure/regions/azurerm"
  version = "~> 0.3"
}

resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.3"
}

resource "azurerm_resource_group" "this" {
  location = module.regions.regions[random_integer.region_index.result].name
  name     = module.naming.resource_group.name_unique
}

resource "azurerm_virtual_network" "this" {
  address_space       = ["10.0.1.0/24"]
  location            = azurerm_resource_group.this.location
  name                = "vnet1"
  resource_group_name = azurerm_resource_group.this.name
}

# reference the module and pass in variables as needed
module "private_dns_zones" {
  # replace source with the correct link to the private_dns_zones module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"  
  source                = "../../"
  enable_telemetry      = local.enable_telemetry
  resource_group_name   = azurerm_resource_group.this.name
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
}
