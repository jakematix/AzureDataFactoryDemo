

# First, the Resource Group is created.
module "ResourceGroup" {
  source         = "./ResourceGroup"
  name_construct = var.env_name
  region         = var.azure_region
}

# Next, Create Azure Key Vault and access groups
module "KeyVault" {
  source         = "./KeyVault"
  name_construct = var.env_name
  region         = var.azure_region
  rg_name        = module.ResourceGroup.rg_out_name
}

# Next, the Storage Account with Blob and the source data is uploaded.
module "StorageAccount" {
  source         = "./StorageAccount"
  name_construct = var.env_name
  region         = var.azure_region
  rg_name        = module.ResourceGroup.rg_out_name
  container_name = "sourcedata"
  blobname       = "GlobalLandTemperatures.csv"
  sourcepath     = "./data/GlobalLandTemperatures.csv"
  az_keyvault_id = module.KeyVault.azure_kv_id
}

# Ensure, that SQL Database username is in environment variable $env:TF_VAR_sql_db_username.
# In order to grant access to the SQL Server from the home IP, the $env:TF_VAR_home_ip need to be defined 
# with your home IP address.
module "SqlDatabase" {
  source          = "./SqlDatabase"
  name_construct  = "DataFactoryDemo"
  region          = "West Europe"
  rg_name         = module.ResourceGroup.rg_out_name
  sql_db_username = var.sql_db_username
  az_keyvalt_id   = module.KeyVault.azure_kv_id
  allowed_ip      = var.allowed_sql_login_ip
}

module "DataFactory" {
  source                                      = "./DataFactory"
  name_construct                              = var.env_name
  region                                      = var.azure_region
  rg_name                                     = module.ResourceGroup.rg_out_name
  rg_id                                       = module.ResourceGroup.rg_id
  kv_id                                       = module.KeyVault.azure_kv_id
  kv_secrets_officer_group_id                 = module.ResourceGroup.kv_secrets_id
  storage_kv_secret_name                      = module.StorageAccount.connectionstring_kv_secret_name
  sql_server_connection_string_kv_secret_name = module.SqlDatabase.sql_connection_string_kv_secret_name

}






