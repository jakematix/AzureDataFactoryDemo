# Helps to create an unique Data Factory name
#   No special characters (special = false)
#   All character only lower case (upper = false)
resource "random_string" "rnd" {
  length  = 5
  special = false
  upper   = false
}

# Creation of Azure Data Factory
resource "azurerm_data_factory" "datafactory" {
  name                = "${var.name_construct}${random_string.rnd.result}"
  location            = var.region
  resource_group_name = var.rg_name
  identity {
    type = "SystemAssigned"
  }
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

# Creation of the Linked service to the Blob
resource "azurerm_data_factory_linked_service_azure_blob_storage" "bloblink" {
  name              = "${var.name_construct}BlobLink"
  data_factory_id   = azurerm_data_factory.datafactory.id
  connection_string = data.azurerm_key_vault_secret.storage_sec.value
}

# Settings for delimited text aka. CSV file
resource "azurerm_data_factory_dataset_delimited_text" "csvfile" {
  name                = "${var.name_construct}csv"
  data_factory_id     = azurerm_data_factory.datafactory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.bloblink.name

  azure_blob_storage_location {
    filename  = "GlobalLandTemperatures.csv"
    container = "sourcedata"
  }

  column_delimiter    = ","
  row_delimiter       = "NEW"
  encoding            = "UTF-8"
  quote_character     = "x"
  escape_character    = "f"
  first_row_as_header = true
  null_value          = "NULL"
}

# Create link to SQL Database
resource "azurerm_data_factory_linked_service_azure_sql_database" "sqllink" {
  name              = "${var.name_construct}SQLLink"
  data_factory_id   = azurerm_data_factory.datafactory.id
  connection_string = data.azurerm_key_vault_secret.sql_conn_string.value
}

# Create a dataset to SQL table (note that the table does not exist. Need to be create using SQL before executing the demo)
resource "azurerm_data_factory_dataset_azure_sql_table" "sql_dataset" {
  name                = "${var.name_construct}sql"
  data_factory_id     = azurerm_data_factory.datafactory.id
  linked_service_id   = azurerm_data_factory_linked_service_azure_sql_database.sqllink.id
}