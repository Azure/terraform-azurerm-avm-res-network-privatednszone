locals {
  parent_resource_id                 = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_resource_substring = "providers/Microsoft.Authorization/roleDefinitions"
  virtual_network_links = {
    for vnet_key, vnet_link in var.virtual_network_links :
    vnet_key => {
      name                 = coalesce(vnet_link.name, vnet_link.vnetlinkname)
      virtual_network_id   = coalesce(vnet_link.virtual_network_id, vnet_link.vnetid)
      registration_enabled = coalesce(vnet_link.registration_enabled, vnet_link.autoregistration, false)
      resolution_policy    = coalesce(vnet_link.resolution_policy, "Default")
      tags                 = vnet_link.tags
    }
  }
}
