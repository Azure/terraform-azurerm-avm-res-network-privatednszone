resource "azapi_resource" "private_dns_zone_network_link" {
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01"
  body = {
    properties = {
      registrationEnabled = var.registration_enabled
      resolutionPolicy    = var.resolution_policy
      virtualNetwork = {
        id = var.virtual_network_id
      }
    }
  }
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
