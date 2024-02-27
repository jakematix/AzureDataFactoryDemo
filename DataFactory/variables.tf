variable "name_construct" {
  type        = string
  description = "The basic name of to construct the actual name"
}

variable "rg_name" {
  type        = string
  description = "The RG name"
}

variable "rg_id" {
  type        = string
  description = "The Resource Group Id"
}

variable "region" {
  type        = string
  description = "Azure region name"
}

variable "kv_id" {
  type        = string
  description = "Kay Vault ID"
}

variable "kv_secrets_officer_group_id" {
  type        = string
  description = "Key Vault secrets officers group id"
}

variable "storage_kv_secret_name" {
  type        = string
  description = "Storage secret name in the Key Vault"
}

variable "sql_server_connection_string_kv_secret_name" {
  type        = string
  description = "SQL connection string name in the Key Vault"
}

variable "storage_account_id" {
  type        = string
  description = "Storage Account Id"

}

variable "sql_server_id" {
  type        = string
  description = "SQL Server Id"

}

variable "vnet_id" {
  type        = string
  description = "Virtual Network Id"

}

variable "subnet_id" {
  type        = string
  description = "Subnet Id"

}