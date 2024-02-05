terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.88.0"
    }
  }
}

provider "azurerm" {

  subscription_id = var.demo_sub_id
  client_id       = var.demo_client_id
  tenant_id       = var.demo_tenant_id
  client_secret   = var.demo_client_secret

  features {

  }
}
