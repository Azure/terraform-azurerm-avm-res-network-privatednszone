resource "azapi_resource" "mx_record" {
  # This resource creates an MX record provided by the user in the Private DNS Zone using the Azure API
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Network/privateDnsZones/MX@2024-06-01"
  body = {
    properties = {
      mxRecords = var.records
      ttl       = var.ttl
    }
  }
  response_export_values = {
    "id"   = "id"
    "name" = "name"
    "type" = "type"
    "fqdn" = "properties.fqdn"
    "ttl"  = "properties.ttl"
  }
  retry = var.retry

  timeouts {
    create = var.timeouts.create
    delete = var.timeouts.delete
    read   = var.timeouts.read
    update = var.timeouts.update
  }
}
