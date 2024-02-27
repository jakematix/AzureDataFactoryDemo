# Creation of Azure Key Vault to store secrets

data "azurerm_client_config" "current_config" {}

# First we need to generate some random name based on the current time. Key Vault name need to be unique.
resource "random_id" "rnd" {
  keepers = {
    tstamp = "${timestamp()}"
  }
  byte_length = 4
}
resource "azurerm_key_vault" "azure_kv" {
  name                       = "${var.name_construct}${random_id.rnd.hex}"
  location                   = var.region
  resource_group_name        = var.rg_name
  tenant_id                  = data.azurerm_client_config.current_config.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  enable_rbac_authorization  = true
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = [var.allowed_ip_address]
  }
}