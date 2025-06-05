resource "azapi_resource" "cname_record" {
  # This resource creates an CNAME record provided by the user in the Private DNS Zone using the Azure API
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Network/privateDnsZones/CNAME@2024-06-01"
  body = jsonencode({
    properties = {
      cnameRecord = var.cname
      ttl         = var.ttl
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