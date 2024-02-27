variable "sql_db_username" {
  type        = string
  description = "SQL Database username"
  sensitive   = true
}


variable "allowed_ip_address" {
  type        = string
  description = "Allowed IP Address to access the resources"
  sensitive   = true
}

variable "demo_sub_id" {
  type        = string
  description = "Subscription ID is stored in $Env:TF_VAR_demo_sub_id"
}
variable "demo_client_id" {
  type        = string
  description = "Client ID is stored in $Env:TF_VAR_demo_client_id"
}

variable "demo_object_id" {
  type        = string
  description = "Object ID is stored in $Env:TF_VAR_demo_object_id"
}

variable "demo_tenant_id" {
  type        = string
  description = "Tenant ID is stored in $Env:TF_VAR_demo_tenant_id"
}

variable "demo_client_secret" {
  type        = string
  description = "Client Secret is stored in $Env:TF_VAR_demo_client_secret"
  sensitive   = true
}

# Variable env_name is used as name contstructor in the demo
variable "env_name" {
  type        = string
  description = "Environment name that is used as the prefix in the resource names"
}

variable "azure_region" {
  type        = string
  description = "Desired Azure Region"
}

