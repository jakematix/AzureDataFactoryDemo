# Module: StorageAccount
This module creates Azure Storage Account, creates Blob container and uploads the file to the Blob container.
Container name, blob file name and the source file name are given in the root `main.tf` when calling the module. Blob storage connection string is stored in the Key Vault.

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `name_construct` - Constructor for the resource names
* `container_name`- Name of a Blob container that is created
* `blobname`- Name of the file in the Blob container
* `sourcepath`- Source where the file is located for the upload
* `az_keyvault_id`- Azure Key Vault Id

## Outputs in `outputs.tf`
* `stg_account_name_out`- Name of the created Storage Account
* `containername_out`- Name of the created Blob Container
* `blob_file_out`- File name
* `primary_blob_connection_string_out`- Blob connection string
* `connectionstring_kv_secret_name` - Name of the Secret in the Key Vault that holds the Blob connection string
