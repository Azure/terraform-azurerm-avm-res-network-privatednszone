resource "azapi_resource" "a_record" {
  # This resource creates an A record provided by the user in the Private DNS Zone using the Azure API
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Network/privateDnsZones/A@2024-06-01"
  body = {
    properties = {
      aRecords = local.dns_a_records
      ttl      = var.ttl
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
