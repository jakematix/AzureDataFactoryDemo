terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

# Helps to create an unique Storage Account name
#   No special characters (special = false)
#   All character only lower case (upper = false)
resource "random_string" "rnd" {
  length  = 5
  special = false
  upper   = false
}

# ---------------------------------------------------------------------------------------------------------------
data "azurerm_client_config" "current" {}

data "azurerm_subscription" "subscription" {}

resource "random_id" "rnd" {
  keepers = {
    tstamp = "${timestamp()}"
  }
  byte_length = 4
}

# First create a Private DNS Zone for private endpoint to Blob
resource "azurerm_private_dns_zone" "priv_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.rg_name
}

# Next, create Virtual Network link for the zone
resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_vlink" {
  name                  = "dns-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.priv_dns_zone.name
  virtual_network_id    = var.vnet_id
  depends_on            = [ azurerm_private_dns_zone.priv_dns_zone ]
}

# Creation of Azure Storage Account with name that is defines in name_construct variable with 5 random characters
resource "azurerm_storage_account" "StgAccount" {
  name                          = "${lower(var.name_construct)}${random_string.rnd.result}"
  resource_group_name           = var.rg_name
  location                      = var.region
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = false
}

# Store the connection string in the Key Vault as a secret.
resource "azurerm_key_vault_secret" "blob_secret" {
  name         = "${lower(var.name_construct)}storage"
  value        = azurerm_storage_account.StgAccount.primary_blob_connection_string
  key_vault_id = var.az_keyvault_id
}


# Creation of the Private Endpoint in the given subnet
resource "azurerm_private_endpoint" "vm_stor_private_endpoint" {
    name                             = "VM-Storage-Private-Endpoint"
    location                         = var.region
    resource_group_name              = var.rg_name
    subnet_id                        = var.subnet_id
    
    private_dns_zone_group {
      name                           = "default"
      private_dns_zone_ids           = [azurerm_private_dns_zone.priv_dns_zone.id]
    }

    private_service_connection {
      name                           = "vmstor-private-service-connection"
      private_connection_resource_id = azurerm_storage_account.StgAccount.id
      subresource_names              = ["blob"]
      is_manual_connection           = false
    }
    depends_on                       = [ azurerm_storage_account.StgAccount ]
}
