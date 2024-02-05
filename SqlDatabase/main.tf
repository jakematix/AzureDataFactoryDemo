# In this Module, MS SQL Server and MS SQL Database is created.
# SQL Server is using SA authentication. Username is stored in Windows Environment Variable TF_VAR_sql_db_username
# and the password is created in this module using random value.
# Password is stored in the Azure Key Vault.


# Creation of the random password based on the current time stamp.
resource "random_id" "rnd" {
  keepers = {
    tstamp = "${timestamp()}"
  }
  byte_length = 15
}

# Store the value to Azure Key vault. Key is "sqlpwd"
resource "azurerm_key_vault_secret" "sql_password" {
  name         = "${lower(var.name_construct)}sqlpwd"
  value        = "${random_id.rnd.hex}SQ51"
  key_vault_id = var.az_keyvalt_id
}
# Creates MS SQL Database and SQL Server
# SA authentication is used, username and password are provided as environment variables

resource "azurerm_mssql_server" "sqlserver" {
  name                          = "${lower(var.name_construct)}sqlserver"
  resource_group_name           = var.rg_name
  location                      = var.region
  version                       = "12.0"
  administrator_login           = var.sql_db_username
  administrator_login_password  = azurerm_key_vault_secret.sql_password.value
  public_network_access_enabled = true
}

resource "azurerm_mssql_database" "sqldatabase" {
  name      = "${var.name_construct}SQL"
  server_id = azurerm_mssql_server.sqlserver.id
  collation = "SQL_Latin1_General_CP1_CI_AS"

  auto_pause_delay_in_minutes = 60
  max_size_gb                 = 1
  min_capacity                = 0.5
  read_scale                  = false
  zone_redundant              = false
  sku_name                    = "GP_S_Gen5_1"

  depends_on = [azurerm_mssql_server.sqlserver]
}

resource "azurerm_key_vault_secret" "sql_connection_string" {
  name         = "sqlconnectionstring"
  value        = "Server=tcp:${azurerm_mssql_server.sqlserver.name}.database.windows.net,1433;Initial Catalog=${azurerm_mssql_database.sqldatabase.name};Persist Security Info=False;User ID=${var.sql_db_username};Password=${azurerm_key_vault_secret.sql_password.value};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = var.az_keyvalt_id
}


# The Azure feature Allow access to Azure services 
# can be enabled by setting start_ip_address and end_ip_address to 0.0.0.0
# which (is documented in the Azure API Docs).
resource "azurerm_mssql_firewall_rule" "firewallrules" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "homerule" {
  name             = "AllowHomeConnection"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = var.allowed_ip
  end_ip_address   = var.allowed_ip
}

