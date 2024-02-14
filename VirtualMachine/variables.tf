
variable "rg_name" {
  type        = string
  description = "The RG name"
}

variable "region" {
  type        = string
  description = "Azure region name"
}

variable "vm_name" {
    type = string
    description = "Virtual Machine name"
  
}

variable "subnet_id" {
  type = string
  description = "Subnet ID"
}

variable "vm_size" {
  type = string
  description = "VM Size"
}

variable "vm_admin_username" {
    type = string
    description = "VM admin username" 
}

variable "vm_admin_password" {
    type = string
    sensitive = true
    description = "VM admin pwd"
}