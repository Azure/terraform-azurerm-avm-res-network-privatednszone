# Adding DNS PTR record module

This module is used to add DNS PTR record to an existing private DNS zone.

## Features

This module supports adding a DNS PTR record to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent_id** and **name** , then followed by the optional variables representing the DNS record.

### Example - Basic PTR record

This example shows the most basic usage of the module. It adds PTR records to an existing private DNS zone using the for_each iteration.

```terraform

locals {
  ptr_records = {
    "ptr_record1" = {
      name    = "ptr1"
      ttl     = 300
      records = ["web1.testlab.io", "web2.testlab.io"]
      tags = {
        "env" = "prod"
      }
    }

    "ptr_record2" = {
      name    = "ptr2"
      ttl     = 300
      records = ["web1.testlab.io", "web2.testlab.io"]
      tags = {
        "env" = "dev"
      }
    }

  }
}

module "dns_ptr_record" {
  for_each  = local.ptr_records
  source    = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/private_dns_ptr_record"
  parent_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/privateDnsZones/mydomain.com"
  name      = each.value.name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = each.value.tags
}

```
