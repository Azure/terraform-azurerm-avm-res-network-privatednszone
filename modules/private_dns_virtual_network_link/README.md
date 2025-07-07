<!-- BEGIN_TF_DOCS -->
# Adding Private DNS Zone Virtual Network Link module

This module is used to add a virtual network link to an existing private DNS zone.

## Features

This module supports adding a virtual network link to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent\_id**, **name**, and **virtual\_network\_id** , then followed by the optional variables representing the virtual network link.

### Example - Basic virtual network link

This example shows the most basic usage of the module. It creates virtual network links to an existing private DNS zone using the for\_each iteration.

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

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.5)

## Resources

The following resources are used by this module:

- [azapi_resource.private_link_zone_network_link](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the virtual network link.

Type: `string`

### <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id)

Description: The ID of the parent resource to which this virtual network link belongs.

Type: `string`

### <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id)

Description: The ID of the virtual network to link to the private DNS zone.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_private_dns_zone_supports_private_link"></a> [private\_dns\_zone\_supports\_private\_link](#input\_private\_dns\_zone\_supports\_private\_link)

Description: Indicates whether the private DNS zone supports private link.

Type: `bool`

Default: `false`

### <a name="input_registration_enabled"></a> [registration\_enabled](#input\_registration\_enabled)

Description: Indicates whether the virtual network link allows automatic registration of virtual machine DNS records in the private DNS zone.

Type: `bool`

Default: `false`

### <a name="input_resolution_policy"></a> [resolution\_policy](#input\_resolution\_policy)

Description: The Azure private link zone resolution policy for the virtual network link. Possible values are 'Default' or 'NxDomainRedirect'. If the private DNS zone is not an Azure private link zone (e.g. privatelink.blob.core.windows.net), this value is ignored.

Type: `string`

Default: `"Default"`

### <a name="input_retry"></a> [retry](#input\_retry)

Description: Retry configuration for the resource operations

Type:

```hcl
object({
    error_message_regex  = optional(list(string), ["ReferencedResourceNotProvisioned", "CannotDeleteResource"])
    interval_seconds     = optional(number, 10)
    max_interval_seconds = optional(number, 180)
    multiplier           = optional(number, 1.5)
    randomization_factor = optional(number, 0.5)
  })
```

Default: `{}`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) Tags of the resource.

Type: `map(string)`

Default: `null`

### <a name="input_timeouts"></a> [timeouts](#input\_timeouts)

Description: Custom timeouts for the virtual network link operations.

Type:

```hcl
object({
    create = optional(string, "10m")
    update = optional(string, "10m")
    read   = optional(string, "10m")
    delete = optional(string, "10m")
  })
```

Default:

```json
{
  "create": "10m",
  "delete": "10m",
  "read": "10m",
  "update": "10m"
}
```

## Outputs

The following outputs are exported:

### <a name="output_resource"></a> [resource](#output\_resource)

Description: The outputs of the virtual network link resource.

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: The resource ID of the created virtual network link.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->