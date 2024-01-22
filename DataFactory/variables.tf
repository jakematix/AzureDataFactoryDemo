variable "name_construct" {
    type        = string
    description = "The basic name of to construct the actual name"
}

variable "rg_name" {
    type        = string
    description = "The RG name"
}

variable "region" {
    type = string
    description = "Azure region name"
}

variable "blob_connection_string" {
   type = string
   description = "Blob primary connection string"
}
