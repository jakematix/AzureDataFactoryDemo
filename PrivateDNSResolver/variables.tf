
variable "rg_name" {
  type        = string
  description = "The RG name"
}

variable "region" {
  type        = string
  description = "Azure region name"
}

variable "vnet_id" {
  type        = string
  description = "Virtual Network Id"

}

variable "vnet_name" {
  type        = string
  description = "Virtual Network Name"
}

variable "inb_subnet_address_space" {
  type        = string
  description = "Address space of the Subnet that is created for Inbound Endpoint"

}