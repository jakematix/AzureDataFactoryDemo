terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

# Helps to create an unique Storage Account name
#   No special characters (special = false)
#   All character only lower case (upper = false)
resource "random_string" "rnd" {
    length = 5
    special = false
    upper = false
}

# Creation of Azure Storage Account with name that is defines in name_construct variable with 5 random characters
resource "azurerm_storage_account" "StgAccount" {
  name                     = "${lower(var.name_construct)}${random_string.rnd.result}"
  resource_group_name      = var.rg_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Creation of the container to Azure Blob
resource "azurerm_storage_container" "blobcontainer" {
    name                   = var.container_name
    storage_account_name   = azurerm_storage_account.StgAccount.name
    container_access_type  = "private"
}

# Uploading the source document to the Blob container
resource "azurerm_storage_blob" "blobupload" {
    name                   = var.blobname
    storage_account_name   = azurerm_storage_account.StgAccount.name
    storage_container_name = azurerm_storage_container.blobcontainer.name
    type                   = "Block"
    source                 = var.sourcepath
}