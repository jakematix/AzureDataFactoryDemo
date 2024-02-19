output "stg_account_name_out" {
  value = resource.azurerm_storage_account.StgAccount.name
}


output "primary_blob_connection_string_out" {
  value = resource.azurerm_storage_account.StgAccount.primary_blob_connection_string
}

output "connectionstring_kv_secret_name" {
  value = resource.azurerm_key_vault_secret.blob_secret.name
}

output "storage_account_id" {
  value = resource.azurerm_storage_account.StgAccount.id
}