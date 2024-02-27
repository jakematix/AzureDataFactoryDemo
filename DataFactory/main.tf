# Helps to create an unique Data Factory name
#   No special characters (special = false)
#   All character only lower case (upper = false)
resource "random_string" "rnd" {
  length  = 5
  special = false
  upper   = false
}

# Creation of Azure Data Factory with Managed Virtual Network.
# Public access is disabled.
resource "azurerm_data_factory" "datafactory" {
  name                = "${var.name_construct}${random_string.rnd.result}"
  location            = var.region
  resource_group_name = var.rg_name
  identity {
    type = "SystemAssigned"
  }
  managed_virtual_network_enabled = true
  public_network_enabled          = false
}

# Create a Private DNS Zone for private endpoint to Data Factory
resource "azurerm_private_dns_zone" "priv_dns_zone" {
  name                = "privatelink.datafactory.azure.net"
  resource_group_name = var.rg_name
}


# Create Virtual Network link for the zone
resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_vlink" {
  name                  = "dns-link-df"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.priv_dns_zone.name
  virtual_network_id    = var.vnet_id
  depends_on            = [azurerm_private_dns_zone.priv_dns_zone]
}


# Creation of the Private Endpoint in the given subnet
resource "azurerm_private_endpoint" "df_private_endpoint" {
  name                = "DataFactory-Private-Endpoint"
  location            = var.region
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.priv_dns_zone.id]
  }

  private_service_connection {
    name                           = "datafactory-service-connection"
    private_connection_resource_id = azurerm_data_factory.datafactory.id
    subresource_names              = ["dataFactory"]
    is_manual_connection           = false
  }
  depends_on = [azurerm_data_factory.datafactory]
}

# Role assignment for the Data Factory as Key Vault Secrets Officer in order to get secrets from the Key Vault
resource "azurerm_role_assignment" "df_role_assignment" {
  principal_id         = azurerm_data_factory.datafactory.identity.0.principal_id
  scope                = var.rg_id
  role_definition_name = "Key Vault Secrets Officer"
}

# Creation of the Data Factory pipeline
resource "azurerm_data_factory_pipeline" "datafactorypipeline" {
  name            = "${var.name_construct}BlobToSQL"
  data_factory_id = azurerm_data_factory.datafactory.id
}

# Get Blob connection string key from the Key Vault
data "azurerm_key_vault_secret" "storage_sec" {
  name         = var.storage_kv_secret_name
  key_vault_id = var.kv_id
}

# Get SQL Server Connection string from the Key Vault
data "azurerm_key_vault_secret" "sql_conn_string" {
  name         = var.sql_server_connection_string_kv_secret_name
  key_vault_id = var.kv_id
}

# Creation of the new Integration Runtime
resource "azurerm_data_factory_integration_runtime_azure" "ir" {
  name                    = "${var.name_construct}-IR"
  data_factory_id         = azurerm_data_factory.datafactory.id
  location                = var.region
  virtual_network_enabled = true
  compute_type            = "General"
  core_count              = 8
  time_to_live_min        = 10
}

# Creation of the Managed Private Endpoint to Blob storage.
# NOTE! You need to manually approve the Endpoint in Azure Portal as post work
resource "azurerm_data_factory_managed_private_endpoint" "df_managed_endpoint_storage" {
  name               = "${var.name_construct}-AzureBlob-MPE"
  data_factory_id    = azurerm_data_factory.datafactory.id
  target_resource_id = var.storage_account_id
  subresource_name   = "blob"
}


# Creation of the Linked service to the Blob
#  connection_string       = data.azurerm_key_vault_secret.storage_sec.value
resource "azurerm_data_factory_linked_service_azure_blob_storage" "bloblink" {
  name                     = "${var.name_construct}BlobLink"
  data_factory_id          = azurerm_data_factory.datafactory.id
  connection_string        = data.azurerm_key_vault_secret.storage_sec.value
  integration_runtime_name = azurerm_data_factory_integration_runtime_azure.ir.name
}

# Creation of the Managed Private Endpoint to Key Vault
resource "azurerm_data_factory_managed_private_endpoint" "df_managed_endpoint_keyvault" {
  name               = "${var.name_construct}-AzureKeyVault-MPE"
  data_factory_id    = azurerm_data_factory.datafactory.id
  target_resource_id = var.kv_id
  subresource_name   = "vault"
}

# Creation of the Linked service to the Key Vault
resource "azurerm_data_factory_linked_service_key_vault" "keyvaultlink" {
  name                     = "${var.name_construct}KeyVaultLink"
  data_factory_id          = azurerm_data_factory.datafactory.id
  key_vault_id             = var.kv_id
  integration_runtime_name = azurerm_data_factory_integration_runtime_azure.ir.name
}




# Settings for delimited text aka. CSV file
#resource "azurerm_data_factory_dataset_delimited_text" "csvfile" {
#  name                = "${var.name_construct}csv"
#  data_factory_id     = azurerm_data_factory.datafactory.id
#  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.bloblink.name
#
#  azure_blob_storage_location {
#    filename  = "GlobalLandTemperatures.csv"
#    container = "sourcedata"
#  }
#
#  column_delimiter    = ","
#  quote_character     = "\""
#  escape_character    = "\\"
#  first_row_as_header = true
#}

# Creation of the Managed Private Endpoint to SQL Server.
# NOTE! You need to manually approve the Endpoint in Azure Portal as post work
resource "azurerm_data_factory_managed_private_endpoint" "df_managed_endpoint_sql_server" {
  name               = "${var.name_construct}-AzureSQL-MPE"
  data_factory_id    = azurerm_data_factory.datafactory.id
  target_resource_id = var.sql_server_id
  subresource_name   = "sqlServer"
}


# Create link to SQL Database
# connection_string = data.azurerm_key_vault_secret.sql_conn_string.value
resource "azurerm_data_factory_linked_service_azure_sql_database" "sqllink" {
  name                     = "${var.name_construct}SQLLink"
  data_factory_id          = azurerm_data_factory.datafactory.id
  integration_runtime_name = azurerm_data_factory_integration_runtime_azure.ir.name
  connection_string        = data.azurerm_key_vault_secret.sql_conn_string.value
}

# Create a dataset to SQL table (note that the table does not exist. Need to be create using SQL before executing the demo)
#resource "azurerm_data_factory_dataset_azure_sql_table" "sql_dataset" {
#  name                = "${var.name_construct}sql"
#  data_factory_id     = azurerm_data_factory.datafactory.id
#  linked_service_id   = azurerm_data_factory_linked_service_azure_sql_database.sqllink.id
#}