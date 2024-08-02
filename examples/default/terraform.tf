terraform {
  required_version = ">= 1.6, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.6, <= 3.114.0"
    }
  }
}

provider "azurerm" {
  features {}
}