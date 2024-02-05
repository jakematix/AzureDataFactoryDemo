# Module: ResourceGroup
Creates a Resource Group for all the resources, creates user groups and assigns roles for Service Principal to them.

## Varables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `name_construct` - Constructor for the resource names

## Outputs in `outputs.tf`
* `rg_out_name`- Resource Group name
* `rg_id`- Resource Group Id
* `kv_secrets_id`- Id for Key Vault access Key Vault Secrets Officer
