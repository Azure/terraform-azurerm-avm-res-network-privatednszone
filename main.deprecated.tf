# This file contains the deprecated resources and configurations for private DNS zones and related components relying on the AzureRM provider.

# Azurerm Private DNS Zone Moved to Azapi Resource
# Azurerm Private DNS Zone SOA Record block is handled within this block so it will not be deleted but in the plan it should show as a new resource in the state file which is expected.
moved {
  from = azurerm_private_dns_zone.this
  to   = azapi_resource.private_dns_zone
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = local.virtual_network_links_deprecated

  name                  = each.value.vnetlinkname
  private_dns_zone_name = azapi_resource.private_dns_zone.output.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = each.value.vnetid
  registration_enabled  = lookup(each.value, "autoregistration", false)
  tags                  = lookup(each.value, "tags", null)

  timeouts {
    create = var.timeouts.vnet_links.create
    delete = var.timeouts.vnet_links.delete
    read   = var.timeouts.vnet_links.read
    update = var.timeouts.vnet_links.update
  }
}