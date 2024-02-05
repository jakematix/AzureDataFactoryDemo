
output "storage_account_name" {
  value       = module.StorageAccount.stg_account_name_out
  description = "Name of the Storage Account"
}

output "rg_name" {
  value       = module.ResourceGroup.rg_out_name
  description = "Name of the Resource Group"
}

output "blob_container_name" {
  value       = module.StorageAccount.containername_out
  description = "Name of the Container in the Blob Storage"
}

output "blob_file_name" {
  value       = module.StorageAccount.blob_file_out
  description = "Name of the file in the Blob"
}

output "azure_keyvault_id" {
  value       = module.KeyVault.azure_kv_id
  description = "Azure Key Vault Id"
}

output "sql_server_name" {
  value       = module.SqlDatabase.sql_server_name
  description = "SQL Server Name"
}

output "sql_secret_key_pwd" {
  value       = module.SqlDatabase.sql_server_password_kv_secret_name
  description = "Name of the secret key in the Key Vault that refers to SQL server password"
}

output "sql_secret_key_connectionstring" {
  value       = module.SqlDatabase.sql_connection_string_kv_secret_name
  description = "Name of the secret key in the Key Vault that refers to SQL database connection string"
}
