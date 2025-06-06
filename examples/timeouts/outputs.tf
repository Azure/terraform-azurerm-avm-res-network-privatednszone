output "a_record_outputs" {
  description = "The a record output"
  value       = module.private_dns_zone.a_record_outputs
}

output "aaaa_record_outputs" {
  description = "The aaaa record output"
  value       = module.private_dns_zone.aaaa_record_outputs
}

output "cname_record_outputs" {
  description = "The cname record output"
  value       = module.private_dns_zone.cname_record_outputs
}

output "mx_record_outputs" {
  description = "The mx record output"
  value       = module.private_dns_zone.mx_record_outputs
}

output "private_dns_zone_output" {
  description = "The private dns zone output"
  value       = module.private_dns_zone.resource
}

output "ptr_record_outputs" {
  description = "The ptr record output"
  value       = module.private_dns_zone.ptr_record_outputs
}

output "srv_record_outputs" {
  description = "The srv record output"
  value       = module.private_dns_zone.srv_record_outputs
}

output "txt_record_outputs" {
  description = "The txt record output"
  value       = module.private_dns_zone.txt_record_outputs
}

output "virtual_network_link_outputs" {
  description = "The virtual network link output"
  value       = module.private_dns_zone.virtual_network_link_outputs
}
