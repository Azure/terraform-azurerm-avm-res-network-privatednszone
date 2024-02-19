output "private_dns_zone_output" {
  value       = module.private_dns_zones.private_dnz_zone_output
  description = "The private dns zone output"
}


output "a_record_outputs" {
  value       = module.private_dns_zones.a_record_outputs
  description = "The a record output"
}

output "aaaa_record_outputs" {
  value       = module.private_dns_zones.aaaa_record_outputs
  description = "The aaaa record output"
}

output "virtual_network_link_outputs" {
  value       = module.private_dns_zones.virtual_network_link_outputs
  description = "The virtual network link output"
}

output "cname_record_outputs" {
  value       = module.private_dns_zones.cname_record_outputs
  description = "The cname record output"
}

output "mx_record_outputs" {
  value       = module.private_dns_zones.mx_record_outputs
  description = "The mx record output"
}

output "ptr_record_outputs" {
  value       = module.private_dns_zones.ptr_record_outputs
  description = "The ptr record output"
}

output "srv_record_outputs" {
  value       = module.private_dns_zones.srv_record_outputs
  description = "The srv record output"
}

output "txt_record_outputs" {
  value       = module.private_dns_zones.txt_record_outputs
  description = "The txt record output"
}