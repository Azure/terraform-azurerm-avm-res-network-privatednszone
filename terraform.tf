terraform {
  required_version = ">= 1.6, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.6, < 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1, < 4.0"
    }
  }
}
