# Adding DNS SOA record module

This module is used to add DNS SOA record to an existing private DNS zone.

## Features

This module supports adding a DNS SOA record to an existing private DNS zone.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **parent_id** and **name** , then followed by the optional variables representing the DNS record.

### Example - Basic SOA record

This example shows the most basic usage of the module. It adds SOA records to an existing private DNS zone using the for_each iteration.

```terraform

locals {
  domain_name = "testlab.io"
  soa_record = {
    email = "hostmaster.${local.domain_name}"
  }
}

module "dns_soa_record" {
  source    = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/private_dns_soa_record"
  parent_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Network/privateDnsZones/mydomain.com"
  name      = each.value.name
  tags      = each.value.tags
}

```
