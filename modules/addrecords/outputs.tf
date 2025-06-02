output "dns_record_outputs" {
  description = "The outputs for all the records in the private DNS zone"
  value = {
    for record_name, record in azapi_resource.private_dns_zone_record :
    record_name => {
      id   = record.output.id
      fqdn = record.output.fqdn
    }
  }
}

# Ask Matt about this being required but being singular vs plural
output "resource_id" {
  description = "The resource IDs of the DNS records created"
  value       = [for record in azapi_resource.private_dns_zone_record : record.id]
}
