# Module: StorageAccount
This module creates Azure Storage Account, private DNS zone for `privatelink.blob.core.windows.net`, virtual link to DNS zone and Private Endpoint. Public access is disabled and the Storage Account can be accessed from the subnet where the Front End Virtual Machine is located. 
Blob storage connection string is stored in the Key Vault.

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `name_construct` - Constructor for the resource names
* `az_keyvault_id`- Azure Key Vault Id
* `vnet_id`- Virtual Network Id
* `subnet_id` - Subnet Id


## Outputs in `outputs.tf`
* `stg_account_name_out`- Name of the created Storage Account
* `storage_account_id` - Id of the created Storage Account 
* `primary_blob_connection_string_out`- Blob connection string
* `connectionstring_kv_secret_name` - Name of the Secret in the Key Vault that holds the Blob connection string
