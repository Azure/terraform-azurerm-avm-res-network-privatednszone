<!-- BEGIN_TF_DOCS -->
# Add DNS entries to existing private DNS zone

This is an example that adds DNS records to an existing private DNS zone using record type sub-modules.

```hcl
# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg"
}

module "private_dns_zone" {
  # replace source with the correct link to the private_dns_zone module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"  
  source = "../../"

  domain_name         = local.domain_name
  resource_group_name = azurerm_resource_group.avmrg.name
  subscription_id     = var.subscription_id
}

module "a_record" {
  source   = "../../modules/private_dns_a_record"
  for_each = local.a_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = each.value.records
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "aaaa_record" {
  source   = "../../modules/private_dns_aaaa_record"
  for_each = local.aaaa_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = each.value.records
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "cname_record" {
  source   = "../../modules/private_dns_cname_record"
  for_each = local.cname_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  record    = each.value.record
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "mx_record" {
  source   = "../../modules/private_dns_mx_record"
  for_each = local.mx_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = values(each.value.records)
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "ptr_record" {
  source   = "../../modules/private_dns_ptr_record"
  for_each = local.ptr_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = each.value.records
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "srv_record" {
  source   = "../../modules/private_dns_srv_record"
  for_each = local.srv_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = values(each.value.records)
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "txt_record" {
  source   = "../../modules/private_dns_txt_record"
  for_each = local.txt_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = values(each.value.records)
  ttl       = each.value.ttl
  tags      = each.value.tags
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 4.0, < 5.0)

## Resources

The following resources are used by this module:

- [azurerm_resource_group.avmrg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id)

Description: The ID of the Azure subscription where the resources will be created.

Type: `string`

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

### <a name="output_private_dns_zone_output"></a> [private\_dns\_zone\_output](#output\_private\_dns\_zone\_output)

Description: The private dns zone output

### <a name="output_ptr_record_outputs"></a> [ptr\_record\_outputs](#output\_ptr\_record\_outputs)

Description: The ptr record output

### <a name="output_srv_record_outputs"></a> [srv\_record\_outputs](#output\_srv\_record\_outputs)

Description: The srv record output

### <a name="output_txt_record_outputs"></a> [txt\_record\_outputs](#output\_txt\_record\_outputs)

Description: The txt record output

## Modules

The following Modules are called:

### <a name="module_a_record"></a> [a\_record](#module\_a\_record)

Source: ../../modules/private_dns_a_record

Version:

### <a name="module_aaaa_record"></a> [aaaa\_record](#module\_aaaa\_record)

Source: ../../modules/private_dns_aaaa_record

Version:

### <a name="module_cname_record"></a> [cname\_record](#module\_cname\_record)

Source: ../../modules/private_dns_cname_record

Version:

### <a name="module_mx_record"></a> [mx\_record](#module\_mx\_record)

Source: ../../modules/private_dns_mx_record

Version:

### <a name="module_private_dns_zone"></a> [private\_dns\_zone](#module\_private\_dns\_zone)

Source: ../../

Version:

### <a name="module_ptr_record"></a> [ptr\_record](#module\_ptr\_record)

Source: ../../modules/private_dns_ptr_record

Version:

### <a name="module_srv_record"></a> [srv\_record](#module\_srv\_record)

Source: ../../modules/private_dns_srv_record

Version:

### <a name="module_txt_record"></a> [txt\_record](#module\_txt\_record)

Source: ../../modules/private_dns_txt_record

Version:

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->