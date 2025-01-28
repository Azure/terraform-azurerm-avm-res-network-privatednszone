output "a_record_outputs" {
  description = "The a record output"
  value       = module.private_dns_zones.a_record_outputs
}

output "aaaa_record_outputs" {
  description = "The aaaa record output"
  value       = module.private_dns_zones.aaaa_record_outputs
}

output "cname_record_outputs" {
  description = "The cname record output"
  value       = module.private_dns_zones.cname_record_outputs
}

output "mx_record_outputs" {
  description = "The mx record output"
  value       = module.private_dns_zones.mx_record_outputs
}

output "private_dns_zone_output" {
  description = "The private dns zone output"
  value       = module.private_dns_zones.resource
}

output "ptr_record_outputs" {
  description = "The ptr record output"
  value       = module.private_dns_zones.ptr_record_outputs
}

output "srv_record_outputs" {
  description = "The srv record output"
  value       = module.private_dns_zones.srv_record_outputs
}

output "txt_record_outputs" {
  description = "The txt record output"
  value       = module.private_dns_zones.txt_record_outputs
}

output "virtual_network_link_outputs" {
  description = "The virtual network link output"
  value       = module.private_dns_zones.virtual_network_link_outputs
}
