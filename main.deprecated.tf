# This file contains the deprecated resources and configurations for private DNS zones and related components relying on the AzureRM provider.

# Azurerm Private DNS Zone Moved to Azapi Resource
# Azurerm Private DNS Zone SOA Record block is handled within this block so it will not be deleted but in the plan it should show as a new resource in the state file which is expected.
moved {
  from = azurerm_private_dns_zone.this
  to   = azapi_resource.private_dns_zone
}
