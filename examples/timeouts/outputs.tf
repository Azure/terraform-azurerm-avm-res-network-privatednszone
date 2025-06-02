output "dns_record_outputs" {
  description = "The DNS records output"
  value       = module.private_dns_zones.dns_record_outputs
}

output "virtual_network_link_outputs" {
  description = "The virtual network link output"
  value       = module.private_dns_zones.virtual_network_link_outputs
}
