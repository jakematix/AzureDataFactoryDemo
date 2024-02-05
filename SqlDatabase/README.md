# Module: SqlDatabase
This module creates Azure MS SQL Database and SQL Server. The basic SA authentication is used. The username shall be in the Environment Variable `$Env:TF_VAR_sql_db_username` and the IP address that allows the human access shall be in the Environment Variable `$Env:TF_VAR_allowed_sql_login_ip`.

Database SKU is Standard-series (Gen5) with 1 vCore and 1 GB Memory and with Locally-redundant backup storage.

SQL DB name is randomized so that the name contains the name constructor (based on the environment name) and follwed by the randon string. SQL Password is created as randomized value. The password and connection strings are stored in the Key Vault. 

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `name_construct` - Constructor for the resource names
* `sql_db_username` - SQL Database username that needs to be in `$Env:TF_VAR_sql_db_username` environment variable
* `allowed_ip`- The IP address from the human access is available. IP Addess needs to be in `$Env:TF_VAR_allowed_sql_login_ip` environment variable
* `az_keyvalt_id`- Id of the Azure Key Vault

## Outputs in `outputs.tf`
* `mssql_db_name`- Name of the created MS SQL Database
* `sql_server_name`- Name of the created MS SQL Server
* `sql_connection_string_kv_secret_name`- Name of a Secret in the Key Vault that holds the SQL Connection string
* `sql_server_password_kv_secret_name`- Name of a Secret in the Key Vault that holds the created SQL DB password
