resource "azapi_resource" "aaaa_record" {
  # This resource creates an AAAA record provided by the user in the Private DNS Zone using the Azure API
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Network/privateDnsZones/AAAA@2024-06-01"
  body = jsonencode({
    properties = {
      aaaaRecords = var.ip_addresses
      ttl         = var.ttl
    }
  })
  response_export_values = {
    "id"   = "id"
    "name" = "name"
    "type" = "type"
    "fqdn" = "properties.fqdn"
    "ttl"  = "properties.ttl"
  }
  tags = var.tags

  timeouts {
    create = var.timeouts.create
    delete = var.timeouts.delete
    read   = var.timeouts.read
    update = var.timeouts.update
  }
}