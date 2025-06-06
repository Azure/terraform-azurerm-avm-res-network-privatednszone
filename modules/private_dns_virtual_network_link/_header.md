# Adding Private DNS Zone Virtual Network Link module

This module is used to add a virtual network link to an existing private DNS zone.

## Features

This module supports adding a virtual network link to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent_id**, **name**, and **virtual_network_id** , then followed by the optional variables representing the virtual network link.

### Example - Basic virtual network link

This example shows the most basic usage of the module. It creates virtual network links to an existing private DNS zone using the for_each iteration.

```terraform

locals {
  vnet_links = {
    "vnet_hub_primary" = {
      name                 = "primary-hub-mydomain-link"
      virtual_network_id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/myVnetNameEastUS2"
      registration_enabled = true
      resolution_policy    = "NxDomainRedirect"
      tags = {
        "env" = "prod"
      }
    }

    "vnet_hub_dr" = {
      name                 = "dr-hub-mydomain-link"
      virtual_network_id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/myVnetNameCentralUS"
      registration_enabled = true
      resolution_policy    = "NxDomainRedirect"
      tags = {
        "env" = "prod"
      }
    }

  }
}

module "private_dns_zone_vnet_link" {
  for_each             = local.vnet_links
  source               = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/private_dns_virtual_network_link"
  parent_id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/privateDnsZones/mydomain.com"
  name                 = each.value.name
  virtual_network_id   = each.value.virtual_network_id
  registration_enabled = each.value.registration_enabled
  resolution_policy    = each.value.resolution_policy
  tags                 = each.value.tags
}

```
