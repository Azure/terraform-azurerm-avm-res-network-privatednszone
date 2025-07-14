output "private_dns_zone_output" {
  description = "The private dns zone output"
  value       = module.private_dns_zone.resource
}

output "virtual_network_link_outputs" {
  description = "The virtual network link output"
  value       = module.private_dns_zone.virtual_network_link_outputs
}
