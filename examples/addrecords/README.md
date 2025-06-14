<!-- BEGIN_TF_DOCS -->
# Add DNS entries to existing private DNS zone

This is an example that adds DNS records to an existing private DNS zone using sub-module **addrecords**

```hcl
module "addrecords" {
  source = "../../modules/addrecords"

  resource_group_name = local.resource_group_name
  # source = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/addrecords"
  zone_name     = local.zone_name
  a_records     = local.a_records
  aaaa_records  = local.aaaa_records
  cname_records = local.cname_records
  mx_records    = local.mx_records
  ptr_records   = local.ptr_records
  srv_records   = local.srv_records
  txt_records   = local.txt_records
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 4.0, < 5.0)

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

Description: The a record output

### <a name="output_aaaa_record_outputs"></a> [aaaa\_record\_outputs](#output\_aaaa\_record\_outputs)

Description: The aaaa record output

### <a name="output_cname_record_outputs"></a> [cname\_record\_outputs](#output\_cname\_record\_outputs)

Description: The cname record output

### <a name="output_mx_record_outputs"></a> [mx\_record\_outputs](#output\_mx\_record\_outputs)

Description: The mx record output

### <a name="output_ptr_record_outputs"></a> [ptr\_record\_outputs](#output\_ptr\_record\_outputs)

Description: The ptr record output

### <a name="output_srv_record_outputs"></a> [srv\_record\_outputs](#output\_srv\_record\_outputs)

Description: The srv record output

### <a name="output_txt_record_outputs"></a> [txt\_record\_outputs](#output\_txt\_record\_outputs)

Description: The txt record output

## Modules

The following Modules are called:

### <a name="module_addrecords"></a> [addrecords](#module\_addrecords)

Source: ../../modules/addrecords

Version:

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->