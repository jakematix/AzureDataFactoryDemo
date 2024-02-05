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

variable "allowed_ip" {
  type        = string
  description = "Allowed IP address for SQL login"

}

variable "az_keyvalt_id" {
  type        = string
  description = "Azure Key Vault id to store the SQL database password"

}

