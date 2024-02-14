variable "name_construct" {
  type        = string
  description = "The basic name of to construct the actual name"
}

variable "rg_name" {
  type        = string
  description = "The RG name"
}

variable "region" {
  type        = string
  description = "Azure region name"
}

variable "vnet_id" {
    type = string
    description = "Virtual Network Id"
}

variable "subnet_id" {
  type = string
  description = "Subnet Id"
}

variable "az_keyvault_id" {
  type        = string
  description = "Id of the Key Vault where to store secrets"

}

