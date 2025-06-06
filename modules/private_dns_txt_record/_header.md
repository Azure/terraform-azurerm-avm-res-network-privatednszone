# Adding DNS TXT record module

This module is used to add DNS TXT record to an existing private DNS zone.

## Features

This module supports adding a DNS TXT record to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent_id** and **name** , then followed by the optional variables representing the DNS record.

### Example - Basic TXT record

This example shows the most basic usage of the module. It adds TXT records to an existing private DNS zone using the for_each iteration.

```terraform

locals {
  txt_records = {
    "txt_record1" = {
      name = "txt1"
      ttl  = 300
      records = {
        "txtrecordA" = {
          value = "apple"
        }
        "txtrecordB" = {
          value = "banana"
        }
      }
      tags = {
        "env" = "prod"
      }
    }

    "txt_record2" = {
      name = "txt2"
      ttl  = 300
      records = {
        "txtrecordC" = {
          value = "orange"
        }
        "txtrecordD" = {
          value = "durian"
        }
      }
      tags = {
        "env" = "prod"
      }
    }

  }
}

module "dns_txt_record" {
  for_each  = local.txt_records
  source    = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/private_dns_txt_record"
  parent_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/privateDnsZones/mydomain.com"
  name      = each.value.name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = each.value.tags
}

```
