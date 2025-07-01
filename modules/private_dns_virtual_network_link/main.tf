resource "azapi_resource" "private_dns_zone_network_link" {
  location  = "global"
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01"
  body      = var.private_dns_zone_supports_private_link ? local.private_link_private_dns_zone_body : local.custom_private_dns_zone_body
  response_export_values = {
    "id"                   = "id"
    "name"                 = "name"
    "type"                 = "type"
    "virtual_network"      = "properties.virtualNetwork"
    "registration_enabled" = "properties.registrationEnabled"
  }
  tags = var.tags

  timeouts {
    create = var.timeouts.create
    delete = var.timeouts.delete
    read   = var.timeouts.read
    update = var.timeouts.update
  }
}
