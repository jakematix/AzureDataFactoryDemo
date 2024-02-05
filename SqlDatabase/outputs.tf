# Outputs MS SQL Name
output "mssql_db_name" {
  value       = resource.azurerm_mssql_database.sqldatabase.name
  description = "Name of the MS SQL Database"
}

# Outputs SQL Server name
output "sql_server_name" {
  value       = resource.azurerm_mssql_server.sqlserver.name
  description = "Name of the SQL Server that was created"
}

# Outputs secret name in the Key Vault that contains SQL connection string
output "sql_connection_string_kv_secret_name" {
  value       = resource.azurerm_key_vault_secret.sql_connection_string.name
  description = "Name of the secret that contains SQL server connection string"
}

# Outputs secret name in the Key Vault that contains SQL server passworkd
output "sql_server_password_kv_secret_name" {
  value       = resource.azurerm_key_vault_secret.sql_password.name
  description = "Name of the secret that contais SQL Password"
}
