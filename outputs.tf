output "StgAccountName" {
  value = module.StorageAccount.stg_account_name_out
}

output "RgName" {
  value = module.ResourceGroup.rg_out_name
}

output "BlobContainerName" {
    value = module.StorageAccount.containername_out
}

output "BlobFileName" {
    value = module.StorageAccount.blob_file_out
}
