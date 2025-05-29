locals {
  role_definition_resource_substring = "providers/Microsoft.Authorization/roleDefinitions"

  parent_resource_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
}
