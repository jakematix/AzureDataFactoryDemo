# Module: VirtualMachine
Creates Windows Virtual Machine and WindowsOpenSSH extension set.

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `vm_name` - Virtual Machine name
* `vm_size` - Virtual Machine size
* `subnet_id` - Subnet Id 
* `vm_admin_username` - Virtual Machine admin username
* `vm_admin_password` - Virtual Machine admin password 

## Outputs in `outputs.tf`
* `vm_public_ip_address`- Virtual Machine IP Address
* `vm_name` - Virtual Machine name 