data "azurerm_client_config" "current" {}

# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg-locks-test"
}

# reference the module and pass in variables as needed
module "private_dns_zone" {
  # replace source with the correct link to the private_dns_zone module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"
  source = "../../"

  domain_name      = local.domain_name
  parent_id        = local.parent_id
  enable_telemetry = local.enable_telemetry
  lock             = local.lock
  tags             = local.tags
}
