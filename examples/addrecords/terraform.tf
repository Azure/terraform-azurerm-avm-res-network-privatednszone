terraform {
  required_version = ">= 1.9, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0, < 5.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "00000000-0000-0000-0000-000000000000"
}