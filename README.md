# Azure Data Factory Demo - Infrastructure creation using Terraform
This demo shows, how Terraform can be used to create Azure Data Factory.

## Desired Target State
Very simple Azure Data Factory is created using Terraform. The Data Factory copies the CSV-file content from the Azure Blob to MS SQL Database. Picture below shows the environment. 

![Demo Environment](/pictures/datafactorydemo.png)

The following resources are created by Terraform:

* Resource Group
* Azure Key Vault
* Storage Account and Blob Container (csv file containing the source is uploaded to the container)
* MS SQL Database with SQL Server
* Azure Data Factory and Pipeline with Linked Services to the Blob and MS SQL and also related Datasets

User needs to create SQL Table (in `\configdata\table.sql`) to SQL Server using the PowerShell script that is located in `\scripts\executesql.ps1`. Script gets the SQL Database connection string from the Key Vault. User needs also to create copy object in Data Factory Pipeline by connecting the related datasets to the object.

## Description of the Terraform script
Script is modular so that creation of each resources are done in own modules. Please, browse to the each module to see its description in README.md.

Two key variables are in `terraform.tfvars` : Azure Region (`azure_region`) and Environment Name (`env_name`). The Environment Name is used as the name constructor for each created Resource. Some resources are needing unique names. In those cases, the name constuctor follows random strings.

At the end of the deployment, the script outputs the following data for the user:
* `rg_name` - Name of the Resource Group
* `storage_account_name` - Name of the created Storage Account
* `blob_container_name` - Name of the Blob Container
* `blob_file_name` - Name of a file uploaded to the Blob
* `sql_server_name` - Name of the created MS SQL Server
* `sql_secret_key_pwd` - Name of the Secret in the Key Vault that contains randomized SQL DB Password to access the database by the user
* `sql_secret_key_connectionstring` - Name of the Secrwet in the Key Vault that contains SQL DB connection string

## Prerequisites
User needs to create own Service Principal (Application registration) for Terraform in the Azure Subscription. See more from [Register a client application in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app).<br>

The following Windows Environment Variables are needed to be created before applying the Terraform code:<br>

* `$Env:TF_VAR_demo_sub_id` - Azure Subscription Id
* `$Env:TF_VAR_demo_client_id` - Service Principal Client Id
* `$Env:TF_VAR_demo_tenant_id` - Service Principal Tenant Id
* `$Env:TF_VAR_demo_client_secret` - Service Principal Client Secret
* `$Env:TF_VAR_sql_db_username` - SQL Server Username
* `$Env:TF_VAR_allowed_sql_login_ip` - Allowed IP address for user to access the SQL server, if needed.
