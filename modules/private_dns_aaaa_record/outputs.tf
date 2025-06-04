output "resource" {
  description = "The outputs of the DNS record resource."
  value       = azapi_resource.aaaa_record.outputs
}

output "resource_id" {
  description = "The resource ID of the created DNS record."
  value       = azapi_resource.aaaa_record.id
}
