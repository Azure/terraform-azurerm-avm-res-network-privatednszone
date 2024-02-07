# Azure Verified Module for Private DNS Zone

This module provides a generic way to create and manage Private DNS zones in Azure.

To use this module in your Terraform configuration, you'll need to provide values for the required variables. Here's a basic example:

```
module "azure_privatednszone" {
  source = "./path_to_this_module"

  // ... mandatory variables ...
  domain_name = "your.domain.com"
  resource_group_name = "existing_resourcegroup_name"

  // ... other optional variables, see example ...
}
```
