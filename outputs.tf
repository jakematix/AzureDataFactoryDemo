
output "storage_account_name" {
  value       = module.StorageAccount.stg_account_name_out
  description = "Name of the Storage Account"
}

output "rg_name" {
  value       = module.ResourceGroup.rg_out_name
  description = "Name of the Resource Group"
}

output "sql_server_name" {
  value       = module.SqlDatabase.sql_server_name
  description = "SQL Server Name"
}

output "keyvault_name" {
  value       = module.KeyVault.azure_kv_name
  description = "Azure Key Vault Name"

}
output "sql_secret_key_pwd" {
  value       = module.SqlDatabase.sql_server_password_kv_secret_name
  description = "Name of the secret key in the Key Vault that refers to SQL server password"
}

output "sql_secret_key_connectionstring" {
  value       = module.SqlDatabase.sql_connection_string_kv_secret_name
  description = "Name of the secret key in the Key Vault that refers to SQL database connection string"
}

output "dns_inbound_endpoint" {
  value       = module.PrivateDNSResolver.dns_inbound_endpoint
  description = "DNS Inbound IP"
}

output "storage_secret_key_connectionstring" {
  value       = module.StorageAccount.connectionstring_kv_secret_name
  description = "Name of the secret key in the Key Vault that refers to storage connection string"

}