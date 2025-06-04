resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = local.virtual_network_links_deprecated

  name                  = each.value.vnetlinkname
  private_dns_zone_name = azapi_resource.private_dns_zone.outputs.name
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