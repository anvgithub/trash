terraform {

  required_version = ">=0.12"
  
  required_providers {
      azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "dev-resources"
  location = "West US"
}

module "vnet_dev" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }

  tags = {
    environment = "dev"
  }

  depends_on = [azurerm_resource_group.example]
}

  resource "azurerm_resource_group" "example1" {
  name     = "prod-resources"
  location = "East US"
}

module "vnet_prod" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.example1.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }

  tags = {
    environment = "prod"
  }

  depends_on = [azurerm_resource_group.example1]
}
