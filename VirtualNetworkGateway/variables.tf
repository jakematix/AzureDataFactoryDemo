variable "rg_name" {
  type        = string
  description = "The RG name"
}

variable "region" {
  type        = string
  description = "Azure region name"
}

variable "vnet_gateway_subnet_address_space" {
  type        = string
  description = "VNet Gateway Subnet address space"
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "p2s_address_pool" {
  type        = string
  description = "Point-to-site IP Address pool for Virtual Network Gateway"
}