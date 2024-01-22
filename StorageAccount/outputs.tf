output "stg_account_name_out" {
  value = resource.azurerm_storage_account.StgAccount.name
}

output "containername_out" {
  value = resource.azurerm_storage_container.blobcontainer.name
}

output "blob_file_out" {
  value = resource.azurerm_storage_blob.blobupload.name
  
}

output "primary_blob_connection_string_out" {
  value = resource.azurerm_storage_account.StgAccount.primary_blob_connection_string
}
