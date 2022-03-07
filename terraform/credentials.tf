provider "azurerm" {
  features {}
  subscription_id = var.subscription_data_subscription_id
  client_id       = var.subscription_data_client_id
  client_secret   = var.subscription_data_client_secret
  tenant_id       = var.subscription_data_tenant_id
}
