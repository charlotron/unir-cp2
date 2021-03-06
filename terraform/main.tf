terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}

# Creating our resource group
resource "azurerm_resource_group" "resgroup" {
  name     = "cp2resgroup"
  location = var.location

  tags = {
    environment = "CP2"
  }
}

# Create the storage account to save all account related data
resource "azurerm_storage_account" "staccount" {
  name                     = var.storage_account
  resource_group_name      = azurerm_resource_group.resgroup.name
  location                 = azurerm_resource_group.resgroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "CP2"
  }
}

