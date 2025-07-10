# Adding DNS MX record module

This module is used to add DNS MX record to an existing private DNS zone.

## Features

This module supports adding a DNS MX record to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent_id** and **name** , then followed by the optional variables representing the DNS record.

### Example - Basic MX record

This example shows the most basic usage of the module. It adds MX records to an existing private DNS zone using the for_each iteration.

```terraform

locals {
  mx_records = {
    "mx_record1" = {
      name = "primary"
      ttl  = 300
      records = {
        "record1" = {
          preference = 10
          exchange   = "mail1.testlab.io"
        }
        "record2" = {
          preference = 20
          exchange   = "mail2.testlab.io"
        }
      }
      tags = {
        "env" = "prod"
      }
    }

    "msx_record2" = {
      name = "backupmail"
      ttl  = 300
      records = {
        "record3" = {
          preference = 10
          exchange   = "backupmail1.testlab.io"
        }
        "record4" = {
          preference = 20
          exchange   = "backupmail2.testlab.io"
        }
      }
      tags = {
        "env" = "dev"
      }
    }
  }
}

module "dns_mx_record" {
  for_each  = local.mx_records
  source    = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/private_dns_mx_record"
  parent_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/privateDnsZones/mydomain.com"
  name      = each.value.name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = each.value.tags
}

```
