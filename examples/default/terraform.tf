terraform {
  required_version = ">= 1.6.4"
  required_providers {
    # TODO: Ensure all required providers are listed here.
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.81.0"
    }
  }
}

provider "azurerm" {
  features {}
}