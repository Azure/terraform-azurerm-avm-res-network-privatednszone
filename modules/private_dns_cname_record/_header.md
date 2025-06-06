# Adding DNS CNAME record module

This module is used to add DNS CNAME record to an existing private DNS zone.

## Features

This module supports adding a DNS CNAME record to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent_id** and **name** , then followed by the optional variables representing the DNS record.

### Example - Basic CNAME record

This example shows the most basic usage of the module. It adds CNAME records to an existing private DNS zone using the for_each iteration.

```terraform

locals {
  cname_records = {
    "record1" = {
      name   = "my_cname_record1"
      ttl    = 300
      record = "prod.testlab.io"
      tags = {
        "env" = "prod"
      }
    }

    "record2" = {
      name   = "my_cname_record2"
      ttl    = 300
      record = "dev.testlab.io"
      tags = {
        "env" = "dev"
      }
    }
  }
}

module "dns_cname_record" {
  for_each  = local.cname_records
  source    = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/private_dns_cname_record"
  parent_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/privateDnsZones/mydomain.com"
  name      = each.value.name
  ttl       = each.value.ttl
  record    = each.value.record
  tags      = each.value.tags
}

```
