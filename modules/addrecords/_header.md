# Adding DNS records module

This module is used to add DNS records to an existing private DNS zone, however it will be **DEPRECATED** in the future. Please use the other **private_dns_<record_type>_record** submodule accordingly.

## Features

This module supports adding DNS records to an existing private DNS zone. Any DNS records supported by private DNS zone can be added.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **resource_group_name** and **zone_name** , then followed by the optional variables representing the various DNS records.

### Example - Basic A record

This example shows the most basic usage of the module. It adds A records to an existing private DNS zone.

```terraform

locals {
  a_records = {
    "a_record1" = {
      name    = "my_arecord1"
      ttl     = 300
      records = ["10.1.1.1", "10.1.1.2"]
      tags = {
        "env" = "prod"
      }
    }

    "a_record2" = {
      name    = "my_arecord2"
      ttl     = 300
      records = ["10.2.1.1", "10.2.1.2"]
      tags = {
        "env" = "dev"
      }
    }
  }
}

module "addrecords" {
  source              = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/addrecords"
  resource_group_name = "testrg"
  zone_name           = "testlab.io"
  a_records           = local.a_records
}

```
