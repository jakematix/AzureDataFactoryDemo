# Module: DataFactory
Creates Azure Data Factory including the following resources:
* Data Factory with name using the environment name as the name constuctor followed by the random string
* Assigns Azure Key Vault Secrets Officer role for the Service Principal to access the Key Vault
* Data Factory Pipeline with name using the environment name as the name constructor followed by the string "BlobToSQL"
* Integration Runtime to server Managed Private Endpoints
* Managed Private Endpoints to Storage Account and SQL Server (user needs to approve these in Azure Portal after the infrastcucture has been created)
* Linked Service to Azure Blob Storage. Name is using the environmet name as the constructor followed by the string "BlobLink"
* Linked Service to MS SQL Database. Name is using the environmet name as the constructor followed by the string "SQLLink"

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `name_construct` - Constructor for the resource names
* `kv_id` - Azure Key Vault Id
* `kv_secrets_officers_group_id` - Key Vault secrets officers group id
* `storage_kv_secret_name` - Name of the Secret in the Key Vault that contains Blob connection string
* `sql_server_connection_string_kv_secret_name`- Name of the Sectet in the Ket Vault that contains SQL Server connection string
* `storage_account_id`- Storage Account Id that is needed for Managed Private Endopoint
* `sql_server_id` - SQL Server Id that is needed for Managed Private Endpoint

## Outputs in `outputs.tf`
* `data_factory_id` - Id of the created Data Factory

