
variable "rg_name" {
  type        = string
  description = "The RG name"
}

variable "region" {
  type        = string
  description = "Azure region name"
}

variable "vnet_address_space" {
    type = string
    description = "Virtual Network Address space"
}

variable "vnet_name" {
    type = string
    description = "Name of the Virtual Network"
}

variable "vnet_subnet_address_space" {
    type = string
    description = "VNet Subnet address space"
}

variable "subnet_name" {
    type = string
    description = "Name of the Subnet" 
}

variable "allowed_ip_address" {
    type = string
    description = "Allowed IP Address"
}