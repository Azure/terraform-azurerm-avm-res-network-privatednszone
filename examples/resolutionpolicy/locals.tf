locals {
  domain_name      = "privatelink.blob.core.windows.net"
  parent_id        = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.avmrg.name}"
  enable_telemetry = false
  tags = {
    environment = "test"
  }
  virtual_network_links = {
    vnetlink1 = {
      name                                   = "vnetlink1"
      virtual_network_id                     = azurerm_virtual_network.vnet1.id
      registration_enabled                   = true
      resolution_policy                      = "NxDomainRedirect"
      private_dns_zone_supports_private_link = true
      tags = {
        "env" = "prod"
      }
    }
  }
}
