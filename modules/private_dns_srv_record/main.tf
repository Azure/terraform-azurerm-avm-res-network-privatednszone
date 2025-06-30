resource "azapi_resource" "srv_record" {
  # This resource creates an SRV record provided by the user in the Private DNS Zone using the Azure API
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.Network/privateDnsZones/SRV@2024-06-01"
  body = {
    properties = {
      srvRecords = var.records
      ttl        = var.ttl
    }
  }
  response_export_values = {
    "id"   = "id"
    "name" = "name"
    "type" = "type"
    "fqdn" = "properties.fqdn"
    "ttl"  = "properties.ttl"
  }

  timeouts {
    create = var.timeouts.create
    delete = var.timeouts.delete
    read   = var.timeouts.read
    update = var.timeouts.update
  }
}
