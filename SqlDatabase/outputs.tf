output "mssql_db_name_out" {
  value = resource.azurerm_mssql_database.sqldatabase.name
}

output "sql_server_name_out" {
  value = resource.azurerm_mssql_server.sqlserver.name
}