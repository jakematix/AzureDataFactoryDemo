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

variable "sql_db_password" {
    type        = string
    description = "SQL Database password"
    sensitive   = true
}

variable "region" {
    type = string
    description = "Azure region name"
}


