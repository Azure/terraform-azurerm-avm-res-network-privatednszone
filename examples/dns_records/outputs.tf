output "a_record_outputs" {
  description = "The a record output"
  value       = module.a_record.a_record_outputs
}

output "aaaa_record_outputs" {
  description = "The aaaa record output"
  value       = module.aaaa_record.aaaa_record_outputs
}

output "cname_record_outputs" {
  description = "The cname record output"
  value       = module.cname_record.cname_record_outputs
}

output "mx_record_outputs" {
  description = "The mx record output"
  value       = module.mx_record
}

output "private_dns_zone_output" {
  description = "The private dns zone output"
  value       = module.private_dns_zone.resource
}

output "ptr_record_outputs" {
  description = "The ptr record output"
  value       = module.ptr_record.ptr_record_outputs
}

output "srv_record_outputs" {
  description = "The srv record output"
  value       = module.srv_record.srv_record_outputs
}

output "txt_record_outputs" {
  description = "The txt record output"
  value       = module.txt_record.txt_record_outputs
}