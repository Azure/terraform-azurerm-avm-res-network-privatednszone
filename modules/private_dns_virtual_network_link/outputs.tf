output "resource" {
  description = "The outputs of the virtual network link resource."
  value       = azapi_resource.private_dns_zone_network_link.outputs
}

output "resource_id" {
  description = "The resource ID of the created virtual network link."
  value       = azapi_resource.private_dns_zone_network_link.id
}
