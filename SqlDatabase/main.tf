
# Creates MS SQL Database and SQL Server
# SA authentication is used, username and password are provided as environment variables

resource "azurerm_mssql_server" "sqlserver" {
  name                          = "${lower(var.name_construct)}sqlserver"
  resource_group_name           = var.rg_name
  location                      = var.region
  version                       = "12.0"
  administrator_login           = var.sql_db_username
  administrator_login_password  = var.sql_db_password
  public_network_access_enabled = true
}

resource "azurerm_mssql_database" "sqldatabase" {
  name           = "${var.name_construct}SQL"
  server_id      = azurerm_mssql_server.sqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "BasePrice"
  max_size_gb    = 2
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
  start_ip_address = "88.114.169.114"
  end_ip_address   = "88.114.169.114"
}

