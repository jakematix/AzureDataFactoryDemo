# AzureDataFactoryDemo
This demo shows, how Terraform can be used to create Azure Data Factory.

Demo creates the following resources:
1. Resource Group and needed Entra ID User Groups (owner, contributor, reader and Key Vault Secrets Officer). Service Principal that Terraform is using is assigned to those groups
2. Azure Key Vault where the secrets are stored during the process
3. Azure Storage account with Blob service and container (sourcedata) and finally uploads csv-file (./data/GlobalLandTemperatures.csv) into the container. Blob connection string in stored in the Key Vault as the secret.
4. MS SQL Database and SQL Server. SQL authentication is used. SQL password is generated and stored to the Key Vault as well as the SQL Connection string
5. Azure Data Factory with linked services to the Blob Storage and SQL Database. Datasets to both linked services are also created. Needed connection strings are read from the Key Vault

There is a PowerShell script (executesql.ps1) in the folder .\scripts that creates a Table in SQL Server. The script reads connection string from the Key Vault and needs connection string name ("sqlconnectionstring") for that purpose in the command line.<br>
SQL Query for table creation is in .\configdata\table.sql<br><br>
Format of the execution:<br>
.\scripts\executesql.ps1 --scriptFile .\configdata\table.sql --connectionStringKey sqlconnectionstring

## Prerequisites
You need to create own Service Principal for Terraform in your Azure Subscription.<br>

The following Windows Environment Variables are needed to be created before applying the Terraform code:<br>
$Env:TF_VAR_demo_sub_id = "azure_subscription_id"<br>
$Env:TF_VAR_demo_client_id = "service principal client id"<br>
$Env:TF_VAR_demo_tenant_id = "service principal tenant id"<br>
$Env:TF_VAR_demo_client_secret = "service principal client secret"<br>
$Env:TF_VAR_sql_db_username = "SQL server username"<br>
$Env:TF_VAR_allowed_sql_login_ip = "allowed IP address to access the SQL server"<br>