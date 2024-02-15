output "private_dns_zone_output" {
  value = module.private_dns_zones.private_dnz_zone_output
}


output "a_record_outputs" {
  value = module.private_dns_zones.a_record_outputs
}

output "aaaa_record_outputs" {
  value = module.private_dns_zones.aaaa_record_outputs
}

output "virtual_network_link_outputs" {
  value = module.private_dns_zones.virtual_network_link_outputs
}

output "cname_record_outputs" {
  value = module.private_dns_zones.cname_record_outputs
}

output "mx_record_outputs" {
  value = module.private_dns_zones.mx_record_outputs
}

output "ptr_record_outputs" {
  value = module.private_dns_zones.ptr_record_outputs
}

output "srv_record_outputs" {
  value = module.private_dns_zones.srv_record_outputs
}

output "txt_record_outputs" {
  value = module.private_dns_zones.txt_record_outputs
}