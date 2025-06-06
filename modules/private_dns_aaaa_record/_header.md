# Adding DNS AAAA
This module is used to add DNS AAAA record to an existing private DNS zone.

## Features

This module supports adding a DNS AAAA record to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent_id** and **name** , then followed by the optional variables representing the DNS record.

### Example - Basic A record

This example shows the most basic usage of the module. It adds AAAA records to an existing private DNS zone using the for_each iteration.

```terraform

locals {
  aaaa_records = {
    "record1" = {
      name    = "my_aaaarecord1"
      ttl     = 600
      records = ["fd5d:70bc:930e:d008:0000:0000:0000:7334", "fd5d:70bc:930e:d008::7335"]
      tags = {
        "env" = "prod"
      }
    }

    "record2" = {
      name    = "my_aaaarecord2"
      ttl     = 600
      records = ["fd5d:70bc:930e:d008:0000:0000:0000:7334", "fd5d:70bc:930e:d008::7335"]
      tags = {
        "env" = "dev"
      }
    }
  }
}

module "dns_aaaa_record" {
  for_each     = local.aaaa_records
  source       = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/private_dns_aaaa_record"
  parent_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/privateDnsZones/mydomain.com"
  name         = each.value.name
  ttl          = each.value.ttl
  aaaa_records = each.value.records
  tags         = each.value.tags
}

```
