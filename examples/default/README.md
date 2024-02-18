<!-- BEGIN_TF_DOCS -->
# Default example

This deploys the module in its simplest form.

```hcl
module "private_dns_zones" {
  #source                = "./modules/private_dns_zones"
  #replace source with the correct link to the private_dns_zones module
  source                = "Azure/avm-res-network-privatednszone/azurerm"
  enable_telemetry      = local.enable_telemetry
  resource_group_name   = local.resource_group_name
  domain_name           = local.domain_name
  dns_zone_tags         = local.dns_zone_tags
  soa_record            = local.soa_record
  virtual_network_links = local.virtual_network_links
  a_records             = local.a_records
  aaaa_records          = local.aaaa_records
  cname_records         = local.cname_records
  mx_records            = local.mx_records
  ptr_records           = local.ptr_records
  srv_records           = local.srv_records
  txt_records           = local.txt_records
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.6.4)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.81.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.5.1)

## Providers

No providers.

## Resources

No resources.

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_a_record_outputs"></a> [a\_record\_outputs](#output\_a\_record\_outputs)

Description: n/a

### <a name="output_aaaa_record_outputs"></a> [aaaa\_record\_outputs](#output\_aaaa\_record\_outputs)

Description: n/a

### <a name="output_cname_record_outputs"></a> [cname\_record\_outputs](#output\_cname\_record\_outputs)

Description: n/a

### <a name="output_mx_record_outputs"></a> [mx\_record\_outputs](#output\_mx\_record\_outputs)

Description: n/a

### <a name="output_private_dns_zone_output"></a> [private\_dns\_zone\_output](#output\_private\_dns\_zone\_output)

Description: n/a

### <a name="output_ptr_record_outputs"></a> [ptr\_record\_outputs](#output\_ptr\_record\_outputs)

Description: n/a

### <a name="output_srv_record_outputs"></a> [srv\_record\_outputs](#output\_srv\_record\_outputs)

Description: n/a

### <a name="output_txt_record_outputs"></a> [txt\_record\_outputs](#output\_txt\_record\_outputs)

Description: n/a

### <a name="output_virtual_network_link_outputs"></a> [virtual\_network\_link\_outputs](#output\_virtual\_network\_link\_outputs)

Description: n/a

## Modules

The following Modules are called:

### <a name="module_private_dns_zones"></a> [private\_dns\_zones](#module\_private\_dns\_zones)

Source: Azure/avm-res-network-privatednszone/azurerm

Version:

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->