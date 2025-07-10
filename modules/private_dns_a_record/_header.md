# Adding DNS A record module

This module is used to add DNS A record to an existing private DNS zone.

## Features

This module supports adding a DNS A record to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent_id** and **name** , then followed by the optional variables representing the DNS record.

### Example - Basic A record

This example shows the most basic usage of the module. It adds A records to an existing private DNS zone using the for_each iteration.

```terraform

locals {
  a_records = {
    "record1" = {
      name    = "my_arecord1"
      ttl     = 300
      records = ["10.1.1.1", "10.1.1.2"]
      tags = {
        "env" = "prod"
      }
    }

    "record2" = {
      name    = "my_arecord2"
      ttl     = 300
      records = ["10.2.1.1", "10.2.1.2"]
      tags = {
        "env" = "dev"
      }
    }
  }
}

module "dns_a_record" {
  for_each  = local.a_records
  source    = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/private_dns_a_record"
  parent_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/privateDnsZones/mydomain.com"
  name      = each.value.name
  ttl       = each.value.ttl
  a_records = each.value.records
  tags      = each.value.tags
}

```
