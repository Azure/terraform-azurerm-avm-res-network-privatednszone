resource "azapi_resource" "a_record" {
  # This resource creates an A record provided by the user in the Private DNS Zone using the Azure API
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Network/privateDnsZones/A@2024-06-01"
  body = jsonencode({
    properties = {
      aRecords = var.ip_addresses
      ttl      = var.ttl
    }
  })
  tags = var.tags

  timeouts {
    create = var.timeouts.create
    delete = var.timeouts.delete
    read   = var.timeouts.read
    update = var.timeouts.update
  }
}