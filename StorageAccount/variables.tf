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

variable "container_name" {
  type        = string
  description = "Container name in the Azure Blob storage"
}

variable "blobname" {
  type        = string
  description = "Name of the file in the Blob"
}

variable "sourcepath" {
  type        = string
  description = "Path to the file to be uploaded to the Blob"
}

variable "az_keyvault_id" {
  type        = string
  description = "Id of the Key Vault where to store secrets"

}

