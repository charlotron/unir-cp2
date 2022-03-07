terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}


# Creating our resource group
resource "azurerm_resource_group" "devops-cp2-group" {
  name     = "devops-cp2-ccr-rg"
  location = var.location

  tags = {
    environment = "CP2"
  }
}

# Create the storage account to save all account related data
resource "azurerm_storage_account" "stAccount" {
  name                     = "devopscp2ccrsg"
  resource_group_name      = azurerm_resource_group.devops-cp2-group.name
  location                 = azurerm_resource_group.devops-cp2-group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "CP2"
  }
}

#plan {
#  name      = "20.04.202111100"
#  product   = "null"
#  publisher : "Canonical"
#}
#
#source_image_reference {
#  offer : "0001-com-ubuntu-confidential-vm-focal",
#  publisher : "Canonical",
#  sku : "20_04-lts-cvm",
#  #urn : "Canonical:0001-com-ubuntu-confidential-vm-focal:20_04-lts-cvm:20.04.202111100",
#  version : "20.04.202111100"
#}