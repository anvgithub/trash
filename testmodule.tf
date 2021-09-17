terraform {

  required_version = ">=0.12"
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

    backend "azurerm" {
        resource_group_name  = "system_resource_group"
        storage_account_name = "storageforsystemdata"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}
provider "azurerm" {
skip_provider_registration = "true"
  features {}
}

resource "azurerm_resource_group" "vnet" {
  name     = "my-resources"
  location = "West US"
}
