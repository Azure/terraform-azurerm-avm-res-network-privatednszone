<!-- BEGIN_TF_DOCS -->
# Default example

This deploys the module in its simplest form.

```hcl
# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg"
}

# create first sample virtual network
resource "azurerm_virtual_network" "vnet1" {
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.avmrg.location
  name                = "vnet1"
  resource_group_name = azurerm_resource_group.avmrg.name

  subnet {
    address_prefixes = ["10.0.1.0/24"]
    name             = "subnet1"
  }
}

# create second sample virtual network
resource "azurerm_virtual_network" "vnet2" {
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.avmrg.location
  name                = "vnet2"
  resource_group_name = azurerm_resource_group.avmrg.name

  subnet {
    address_prefixes = ["10.1.1.0/24"]
    name             = "subnet2"
  }
}

# create app registration
resource "azuread_application" "this" {
  display_name = "dnszonecontributor"
}

# create service principal from app
resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id
}


# reference the module and pass in variables as needed
module "private_dns_zones" {
  # replace source with the correct link to the private_dns_zones module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"  
  source = "../../"

  domain_name           = local.domain_name
  resource_group_name   = azurerm_resource_group.avmrg.name
  a_records             = local.a_records
  aaaa_records          = local.aaaa_records
  cname_records         = local.cname_records
  enable_telemetry      = local.enable_telemetry
  mx_records            = local.mx_records
  ptr_records           = local.ptr_records
  role_assignments      = local.role_assignments
  soa_record            = local.soa_record
  srv_records           = local.srv_records
  tags                  = local.tags
  txt_records           = local.txt_records
  virtual_network_links = local.virtual_network_links
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.2)

- <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) (>= 2.40)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 4.0, < 5.0)

## Resources

The following resources are used by this module:

- [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) (resource)
- [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) (resource)
- [azurerm_resource_group.avmrg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [azurerm_virtual_network.vnet1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)
- [azurerm_virtual_network.vnet2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_dns_record_outputs"></a> [dns\_record\_outputs](#output\_dns\_record\_outputs)

Description: The DNS records output

### <a name="output_virtual_network_link_outputs"></a> [virtual\_network\_link\_outputs](#output\_virtual\_network\_link\_outputs)

Description: The virtual network link output

## Modules

The following Modules are called:

### <a name="module_private_dns_zones"></a> [private\_dns\_zones](#module\_private\_dns\_zones)

Source: ../../

Version:

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->