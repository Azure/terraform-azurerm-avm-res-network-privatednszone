output "dns_record_outputs" {
  description = "The outputs for all the records in the private DNS zone"
  value = merge(var.soa_record != null ? {
    "SOA/soa" = {
      id   = azapi_resource.private_dns_zone_soa_record[0].output.id
      fqdn = azapi_resource.private_dns_zone_soa_record[0].output.fqdn
    }
  } : {}, module.dns_records.dns_record_outputs)
}

output "name" {
  description = "The name of private DNS zone"
  value       = azapi_resource.private_dns_zone.name
}

output "resource" {
  description = "The private dns zone output"
  value       = azapi_resource.private_dns_zone.output
}

output "resource_id" {
  description = "The resource id of private DNS zone"
  value       = azapi_resource.private_dns_zone.output.id
}

output "virtual_network_link_outputs" {
  description = "The virtual network link output"
  value = {
    for link_name, link in azapi_resource.private_dns_zone_network_link :
    link_name => {
      id = link.output.id
    }
  }
}
