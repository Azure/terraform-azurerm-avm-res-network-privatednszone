<!-- BEGIN_TF_DOCS -->
# Add DNS entries to existing private DNS zone

This is an example that creates a virttual network link with a non-default resolution policy to an existing private DNS zone using the **private\_dns\_virtual\_network\_link** sub-module.

```hcl
data "azurerm_client_config" "current" {}

# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg"
}

# create first sample virtual network
resource "azurerm_virtual_network" "vnet1" {
  location            = azurerm_resource_group.avmrg.location
  name                = "vnet1"
  resource_group_name = azurerm_resource_group.avmrg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    address_prefixes = ["10.0.1.0/24"]
    name             = "subnet1"
  }
}

# reference the module and pass in variables as needed
module "private_link_dns_zone" {
  # replace source with the correct link to the private_link_dns_zone module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"
  source = "../../"

  domain_name           = local.domain_name
  parent_id             = local.parent_id
  enable_telemetry      = local.enable_telemetry
  tags                  = local.tags
  virtual_network_links = local.virtual_network_links
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.3.0"
}

module "avm_storageaccount" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.5.0"

  location            = azurerm_resource_group.avmrg.location
  name                = module.naming.storage_account.name_unique
  resource_group_name = azurerm_resource_group.avmrg.name
  private_endpoints = {
    private_endpoint_1 = {
      name                          = module.naming.private_endpoint.name_unique
      subnet_resource_id            = "${azurerm_virtual_network.vnet1.id}/subnets/subnet1"
      subresource_name              = "blob"
      private_dns_zone_resource_ids = [module.private_link_dns_zone.resource_id]
    }
  }
  tags = local.tags
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
- [azurerm_virtual_network.vnet1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)
- [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_private_dns_zone_output"></a> [private\_dns\_zone\_output](#output\_private\_dns\_zone\_output)

Description: The private dns zone output

### <a name="output_virtual_network_link_outputs"></a> [virtual\_network\_link\_outputs](#output\_virtual\_network\_link\_outputs)

Description: The virtual network link output

## Modules

The following Modules are called:

### <a name="module_avm_storageaccount"></a> [avm\_storageaccount](#module\_avm\_storageaccount)

Source: Azure/avm-res-storage-storageaccount/azurerm

Version: 0.5.0

### <a name="module_naming"></a> [naming](#module\_naming)

Source: Azure/naming/azurerm

Version: >= 0.3.0

### <a name="module_private_link_dns_zone"></a> [private\_link\_dns\_zone](#module\_private\_link\_dns\_zone)

Source: ../../

Version:

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->