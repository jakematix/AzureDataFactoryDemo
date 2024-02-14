variable "name_construct" {
  type        = string
  description = "The basic name of to construct the actual name"
}

variable "rg_name" {
  type        = string
  description = "The RG name"
}

variable "sql_db_username" {
  type        = string
  description = "SQL Database username"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Azure region name"
}

variable "az_keyvalt_id" {
  type        = string
  description = "Azure Key Vault id to store the SQL database password"

}

variable "vnet_id" {
    type = string
    description = "Virtual Network Id"
}

variable "subnet_id" {
  type = string
  description = "Subnet Id"
}
