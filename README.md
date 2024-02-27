# Azure Data Factory Demo - Infrastructure creation using Terraform
This demo shows, how Terraform can be used to create Azure Data Factory.
More detailed description can be found from this [Wiki](https://github.com/jakematix/AzureDataFactoryDemo/wiki/Azure-Data-Factory-Demo-%E2%80%90-Infrastructure-creation-using-Terraform).

## Desired Target State
Very simple infrastructure for Azure Data Factory is created using Terraform. The user computer imitates to be located in on-premise network (172.16.201/16). Point-to-Site VPN Connection is established from on-premise computer to Virtual Network Gateway. Picture below shows the environment. 

The "on-premise network" does not contain DNS server functionality so it is not possible to make any conditional forwarding rules to the Inbound Endpoint on DNS Private Resolver. The workaround is done in Azure VPN Client configuration. 

![Demo Environment](/pictures/datafactorydemo.png)

The following resources are created by Terraform:

* [Resource Group](/ResourceGroup)
* [Network Security Group, Virtua Network and Subnet](/VirtualNetwork/)
* [Virtual Network Gateway](/VirtualNetworkGateway)
* [DNS Private Resolver](/PrivateDNSResolver/)
* [Azure Key Vault](/KeyVault)
* [Storage Account with Private Endpoint for the VM](/StorageAccount)
* [MS SQL Database with SQL Server with Private Endpoint for the VM](/SqlDatabase)
* [Azure Data Factory and Pipeline, Managed Private Endpoints and Linked Services](/DataFactory)

After the infrastruture is deployed, user can access the Storage Account and SQL Server from the on-premisen computer only - no public access to the resources. There are Private Endpoints for both resources. User needs to create a Blob container, upload the source file and create SQL table. Also the respective Datasets must be created in the Data Factory pipeline as well as the Copy object.

## Description of the Terraform script
Script is modular so that creation of each resources are done in own modules. Please, browse to the each module to see its description in README.md.

Two key variables are in `terraform.tfvars` : Azure Region (`azure_region`) and Environment Name (`env_name`). The Environment Name is used as the name constructor for each created Resource. Some resources are needing unique names. In those cases, the name constuctor follows random strings.

At the end of the deployment, the script outputs the following data for the user:
* `rg_name` - Name of the Resource Group
* `storage_account_name` - Name of the created Storage Account
* `sql_server_name` - Name of the created MS SQL Server
* `azure_keyvault_name` - Azure Key Vault name
* `sql_secret_key_pwd` - Name of the Secret in the Key Vault that contains randomized SQL DB Password to access the database by the user
* `sql_secret_key_connectionstring` - Name of the Secret in the Key Vault that contains SQL DB connection string
* `dns_inbound_enpoint` - IP configuration of the DNS inbound endbpoint. DNS address is needed to configure Azure VPN Client

## Prerequisites
User needs to create own Service Principal (Application registration) for Terraform in the Azure Subscription. See more from [Register a client application in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app).<br>

The following Windows Environment Variables are needed to be created before applying the Terraform code:<br>

* `$Env:TF_VAR_demo_sub_id` - Azure Subscription Id
* `$Env:TF_VAR_demo_client_id` - Service Principal Client Id
* `$Env:TF_VAR_demo_tenant_id` - Service Principal Tenant Id
* `$Env:TF_VAR_demo_client_secret` - Service Principal Client Secret
* `$Env:TF_VAR_sql_db_username` - SQL Server Username
* `$Env:TF_VAR_allowed_ip_address` - Allowed IP address for user to access the SQL server, if needed.
* `$Env:TF_VAR_vm_admin_username` - VM Admin username
* `$Env:TF_VAR_vm_admin_password` - VM Admin password

From this [Wiki](https://github.com/jakematix/AzureDataFactoryDemo/wiki/Azure-Data-Factory-Demo-%E2%80%90-Infrastructure-creation-using-Terraform) you can found the detailed instructions.