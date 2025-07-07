<!-- BEGIN_TF_DOCS -->
# Adding DNS SOA record module

This module is used to add DNS SOA record to an existing private DNS zone.

## Features

This module supports adding a DNS SOA record to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent\_id** and **name** , then followed by the optional variables representing the DNS record.

### Example - Basic SOA record

This example shows the most basic usage of the module. It adds SOA records to an existing private DNS zone using the for\_each iteration.

```terraform

locals {
  domain_name = "testlab.io"
  soa_record = {
    email = "hostmaster.${local.domain_name}"
  }
}

module "dns_soa_record" {
  source    = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/private_dns_soa_record"
  parent_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/privateDnsZones/mydomain.com"
  name      = each.value.name
  tags      = each.value.tags
}

```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.0)

## Resources

The following resources are used by this module:

- [azapi_resource.soa_record](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_email"></a> [email](#input\_email)

Description: The email address of the SOA record.

Type: `string`

### <a name="input_expire_time"></a> [expire\_time](#input\_expire\_time)

Description: The expiration time of the SOA record in seconds.

Type: `number`

### <a name="input_minimum_ttl"></a> [minimum\_ttl](#input\_minimum\_ttl)

Description: The minimum time to live of the record in seconds.

Type: `number`

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the dns record.

Type: `string`

### <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id)

Description: The ID of the parent resource to which this virtual network link belongs.

Type: `string`

### <a name="input_refresh_time"></a> [refresh\_time](#input\_refresh\_time)

Description: The refresh time of the SOA record in seconds.

Type: `number`

### <a name="input_retry_time"></a> [retry\_time](#input\_retry\_time)

Description: The retry time of the SOA record in seconds.

Type: `number`

### <a name="input_ttl"></a> [ttl](#input\_ttl)

Description: The time to live of the record in seconds.

Type: `number`

## Optional Inputs

The following input variables are optional (have default values):

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

### <a name="input_timeouts"></a> [timeouts](#input\_timeouts)

Description: Custom timeouts for the vdns record operations.

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

Description: The outputs of the DNS record resource.

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: The resource ID of the created DNS record.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->