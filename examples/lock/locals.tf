locals {
  domain_name      = "testlab.io"
  enable_telemetry = false
  lock = {
    kind = "CanNotDelete"
    name = "pvt-dns-zone-lock"
  }
  parent_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.avmrg.name}"
  tags = {
    environment = "test"
  }
}
