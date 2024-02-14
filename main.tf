

# First, the Resource Group is created.
module "ResourceGroup" {
  source         = "./ResourceGroup"
  name_construct = var.env_name
  region         = var.azure_region
}

# Creation of the Network Security Group, Virtual Network (VNet) and the subnet
module "VirtualNetwork" {
  source                    = "./VirtualNetwork"
  vnet_name                 = "VNet"
  subnet_name               = "FrontEnd"
  region                    = var.azure_region
  rg_name                   = module.ResourceGroup.rg_out_name
  vnet_address_space        = "10.0.0.0/16"
  vnet_subnet_address_space = "10.0.0.0/24"
  allowed_ip_address        = var.allowed_ip_address
}

# Next, Create Azure Key Vault and access groups
module "KeyVault" {
  source         = "./KeyVault"
  name_construct = var.env_name
  region         = var.azure_region
  rg_name        = module.ResourceGroup.rg_out_name
}

# Creation of the Front End VM
# * Size: Standard B1s (1 vcpu, 1 GiB memory)
# VM Admin username must be present in environment variable $Env:TF_VAR_vm_admin_username
# VM Admin password must be present in environment variable $Env:TF_VAR_vm_admin_password
module "VirtualMachine" {
  source            = "./VirtualMachine"
  vm_name           = "FrontEndVM"
  region            = var.azure_region
  rg_name           = module.ResourceGroup.rg_out_name
  vm_size           = "Standard_B1s"
  vm_admin_username = var.vm_admin_username
  vm_admin_password = var.vm_admin_password
  subnet_id         = module.VirtualNetwork.subnet_id
}

# Creation of the Storage Account
module "StorageAccount" {
  source         = "./StorageAccount"
  name_construct = var.env_name
  region         = var.azure_region
  rg_name        = module.ResourceGroup.rg_out_name
  vnet_id        = module.VirtualNetwork.vnet_id
  subnet_id      = module.VirtualNetwork.subnet_id
  az_keyvault_id = module.KeyVault.azure_kv_id
}

# Ensure, that SQL Database username is in environment variable $env:TF_VAR_sql_db_username.
module "SqlDatabase" {
  source          = "./SqlDatabase"
  name_construct  = var.env_name
  region          = var.azure_region
  rg_name         = module.ResourceGroup.rg_out_name
  sql_db_username = var.sql_db_username
  vnet_id         = module.VirtualNetwork.vnet_id
  subnet_id       = module.VirtualNetwork.subnet_id
  az_keyvalt_id   = module.KeyVault.azure_kv_id
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
  sql_server_id                               = module.SqlDatabase.sql_server_id
  storage_account_id                          = module.StorageAccount.storage_account_id
  

}






