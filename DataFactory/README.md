# Module: DataFactory
Creates Azure Data Factory including the following resources:
* Data Factory with name using the environment name as the name constuctor followed by the random string
* Assigns Azure Key Vault Secrets Officer role for the Service Principal to access the Key Vault
* Data Factory Pipeline with name using the environment name as the name constructor followed by the string "BlobToSQL"
* Linked Service to Azure Blob Storage. Name is using the environmet name as the constructor followed by the string "BlobLink"
* CSV Dataset referring the Linked Service to Blob Storage. Name is using the environmet name as the constructor followed by the string "csv"
* Linked Service to MS SQL Database. Name is using the environmet name as the constructor followed by the string "SQLLink"
* SQL Database Dataset referring the Linked Service to MS SQL Database. Name is using the environmet name as the constructor followed by the string "sql"

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `name_construct` - Constructor for the resource names
* `kv_id` - Azure Key Vault Id
* `kv_secrets_officers_group_id` - Key Vault secrets officers group id
* `storage_kv_secret_name` - Name of the Secret in the Key Vault that contains Blob connection string
* `sql_server_connection_string_kv_secret_name`- Name of the Sectet in the Ket Vault that contains SQL Server connection string

## Outputs in `outputs.tf`
* `data_factory_id` - Id of the created Data Factory

