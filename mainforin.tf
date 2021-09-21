terraform {

  required_version = "=1.0.7"
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.77.0"
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
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West US"
}

resource "azurerm_availability_set" "example" {
  name                = "example-aset"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
  tags                         = var.tags
}

resource "azurerm_public_ip" "example" {
  name                = "loadbalancer-ip"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  domain_name_label   = "loadbalancer.fortest"
  tags                = var.tags
}  
