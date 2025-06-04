resource "azapi_resource" "soa_record" {
  # This resource creates an SOA record provided by the user in the Private DNS Zone using the Azure API
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Network/privateDnsZones/SOA@2024-06-01"
  body = jsonencode({
    properties = {
      soaRecord = {
        email = var.email
      }
    }
  })
  tags = var.tags

  timeouts {
    create = var.timeouts.dns_zones.create
    delete = var.timeouts.dns_zones.delete
    read   = var.timeouts.dns_zones.read
    update = var.timeouts.dns_zones.update
  }
}