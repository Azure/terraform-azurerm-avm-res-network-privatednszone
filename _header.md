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

## NOTE:
When this module is used and terraform plan is run after an initial successful deployment, the following example output(truncated for brevity) may be seen. This is due to updating of Terraform output *resource* value of *number_of_record_sets*. Running apply will only update the Terraform output but will not change infrastructure

```
Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  
      ~ number_of_record_sets                                 = 15 -> 17

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.


```
