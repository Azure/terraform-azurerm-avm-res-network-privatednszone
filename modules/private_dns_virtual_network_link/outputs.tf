output "resource" {
  description = "The outputs of the virtual network link resource."
  value       = var.private_dns_zone_supports_private_link ? azapi_resource.private_link_zone_network_link[0].output : azapi_resource.private_dns_zone_network_link[0].output
}

output "resource_id" {
  description = "The resource ID of the created virtual network link."
  value       = var.private_dns_zone_supports_private_link ? azapi_resource.private_link_zone_network_link[0].id : azapi_resource.private_dns_zone_network_link[0].id
}
