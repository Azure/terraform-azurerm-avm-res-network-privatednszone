locals {
  parent_resource_id                 = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_resource_substring = "providers/Microsoft.Authorization/roleDefinitions"
  virtual_network_links = {
    for vnet_key, vnet_link in var.virtual_network_links :
    "${vnet_key}" => {
      name                 = vnet_link.name
      virtual_network_id   = vnet_link.virtual_network_id
      registration_enabled = lookup(vnet_link, "registration_enabled", false)
      resolution_policy    = lookup(vnet_link, "resolution_policy", "Default")
      tags                 = vnet_link.tags
    } if !var.use_depreacted_virtual_network_link_in_root_module
  }
  virtual_network_links_deprecated = {
    for vnet_key, vnet_link in var.virtual_network_links :
    "${vnet_key}" => {
      vnetlinkname     = vnet_link.name
      vnetid           = vnet_link.virtual_network_id
      autoregistration = lookup(vnet_link, "registration_enabled", false)
      resolutionpolicy = lookup(vnet_link, "resolution_policy", "Default")
      tags             = vnet_link.tags
    } if var.use_depreacted_virtual_network_link_in_root_module
  }
}
