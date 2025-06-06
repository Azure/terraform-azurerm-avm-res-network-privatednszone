<!-- BEGIN_TF_DOCS -->
# Adding DNS records module

This module is used to add DNS records to an existing private DNS zone, however it will be **DEPRECATED** in the future. Please use the other **private\_dns\_<record\_type>\_record** submodule accordingly.

## Features

This module supports adding DNS records to an existing private DNS zone. Any DNS records supported by private DNS zone can be added.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **resource\_group\_name** and **zone\_name** , then followed by the optional variables representing the various DNS records.

### Example - Basic A record

This example shows the most basic usage of the module. It adds A records to an existing private DNS zone.

```terraform

locals {
  a_records = {
    "a_record1" = {
      name    = "my_arecord1"
      ttl     = 300
      records = ["10.1.1.1", "10.1.1.2"]
      tags = {
        "env" = "prod"
      }
    }

    "a_record2" = {
      name    = "my_arecord2"
      ttl     = 300
      records = ["10.2.1.1", "10.2.1.2"]
      tags = {
        "env" = "dev"
      }
    }
  }
}

module "addrecords" {
  source              = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/addrecords"
  resource_group_name = "testrg"
  zone_name           = "testlab.io"
  a_records           = local.a_records
}

```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 4.0, < 5.0)

## Resources

The following resources are used by this module:

- [azurerm_private_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) (resource)
- [azurerm_private_dns_aaaa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_aaaa_record) (resource)
- [azurerm_private_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) (resource)
- [azurerm_private_dns_mx_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_mx_record) (resource)
- [azurerm_private_dns_ptr_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_ptr_record) (resource)
- [azurerm_private_dns_srv_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_srv_record) (resource)
- [azurerm_private_dns_txt_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The resource group of the private DNS zone.

Type: `string`

### <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name)

Description: The name of the private DNS zone.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_a_records"></a> [a\_records](#input\_a\_records)

Description: A map of objects where each object contains information to create a A record.

Type:

```hcl
map(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records)

Description: A map of objects where each object contains information to create a AAAA record.

Type:

```hcl
map(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records)

Description: A map of objects where each object contains information to create a CNAME record.

Type:

```hcl
map(object({
    name   = string
    ttl    = number
    record = string
    tags   = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records)

Description: A map of objects where each object contains information to create a MX record.

Type:

```hcl
map(object({
    name = optional(string, "@")
    ttl  = number
    records = map(object({
      preference = number
      exchange   = string
    }))
    tags = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_ptr_records"></a> [ptr\_records](#input\_ptr\_records)

Description: A map of objects where each object contains information to create a PTR record.

Type:

```hcl
map(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_srv_records"></a> [srv\_records](#input\_srv\_records)

Description: A map of objects where each object contains information to create a SRV record.

Type:

```hcl
map(object({
    name = string
    ttl  = number
    records = map(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
    tags = optional(map(string), null)
  }))
```

Default: `{}`

### <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records)

Description: A map of objects where each object contains information to create a TXT record.

Type:

```hcl
map(object({
    name = string
    ttl  = number
    records = map(object({
      value = string
    }))
    tags = optional(map(string), null)
  }))
```

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_a_record_outputs"></a> [a\_record\_outputs](#output\_a\_record\_outputs)

Description: The a record output

### <a name="output_aaaa_record_outputs"></a> [aaaa\_record\_outputs](#output\_aaaa\_record\_outputs)

Description: The aaaa record output

### <a name="output_cname_record_outputs"></a> [cname\_record\_outputs](#output\_cname\_record\_outputs)

Description: The cname record output

### <a name="output_mx_record_outputs"></a> [mx\_record\_outputs](#output\_mx\_record\_outputs)

Description: The mx record output

### <a name="output_ptr_record_outputs"></a> [ptr\_record\_outputs](#output\_ptr\_record\_outputs)

Description: The ptr record output

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: Added to comply with required\_output\_rmfr7

### <a name="output_srv_record_outputs"></a> [srv\_record\_outputs](#output\_srv\_record\_outputs)

Description: The srv record output

### <a name="output_txt_record_outputs"></a> [txt\_record\_outputs](#output\_txt\_record\_outputs)

Description: The txt record output

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->