locals {
  domain_name      = "testlab-locks.io"
  enable_telemetry = false
  parent_id        = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.avmrg.name}"

  # Resource lock configuration
  lock = {
    kind = "CanNotDelete"
    name = "testlab-locks-dns-lock"
  }

  tags = {
    environment = "test"
    purpose     = "lock-example"
  }
}
