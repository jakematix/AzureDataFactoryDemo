# Module: VirtualNetwork
Creates Virtual Network and Subnet with the Network Security Group (NSG). Access is allowed from the IP address that is defined in `$Env:TF_VAR_allowed_ip_address`. Only ports 3389 (for RDP) and 22 (for SSH) are opened.

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `vnet_address_space` - Virtual Network Address space
* `vnet_name` - Virtual Network name
* `vnet_subnet_address_space` - VNet Subnet address space
* `subnet_name` - Subnet name
* `allowed_ip_address` - IP address from where the Subnet can be accessed

## Outputs in `outputs.tf`
* `vnet_id`- Virtual Network Id
* `subnet_id` - Subnet Id 