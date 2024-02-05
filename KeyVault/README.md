# Module: KeyVault
This module creates Azure Key Vault that is used to store Secrets, like Connection strings and SQL DB password.

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `name_construct` - Constructor for the resource names

## Outputs in `outputs.tf`
* `azure_kv_id` - Key Vault Id

