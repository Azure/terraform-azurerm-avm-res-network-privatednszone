moved {
  from = azurerm_private_dns_zone.this
  to   = azapi_resource.private_dns_zone
}

moved {
  from = azurerm_role_assignment.this
  to   = azapi_resource.role_assignments
}