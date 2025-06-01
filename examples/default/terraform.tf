terraform {
  required_version = ">= 1.9, < 2.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.40"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0, < 5.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.2"
    }
  }
}

provider "azurerm" {
  features {}
}
