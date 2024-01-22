terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.88.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

# First, the Resource Group is created.
module "ResourceGroup" {
  source         = "./ResourceGroup"
  name_construct = "DataFactoryDemo"
  region         = "West Europe"
}

# Next, the Storage Account with Blob and the source data is uploaded.
module "StorageAccount" {
  source         = "./StorageAccount"
  name_construct = "DataFactoryDemo"
  region         = "West Europe"
  rg_name        = module.ResourceGroup.rg_out_name
  container_name = "sourcedata"
  blobname       = "GlobalLandTemperatures.csv"
  sourcepath     = "./data/GlobalLandTemperatures.csv"
}

# Ensure, that SQL Database username is in environment variable $env:TF_VAR_sql_db_username and
# the password is in $env:TF_VAR_sql_db_password
module "SqlDatabase" {
  source         = "./SqlDatabase"
  name_construct = "DataFactoryDemo"
  region         = "West Europe"
  rg_name        = module.ResourceGroup.rg_out_name
  sql_db_username = var.sql_db_username
  sql_db_password = var.sql_db_password
  
}

module "DataFactory" {
  source = "./DataFactory"
  name_construct = "DataFactoryDemo"
  region = "West Europe"
  rg_name = module.ResourceGroup.rg_out_name
  blob_connection_string = module.StorageAccount.primary_blob_connection_string_out
}






