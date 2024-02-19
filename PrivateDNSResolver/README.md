# Module: PrivateDNSResolver
This module cretas Private DNS Resolver that is needed to access Storage account and SQL Server from "on-premise" computer. Also Inbound Endpoint is created.

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `vnet_id` - Virtual Network Id
* `vnet_name` - Virtual Network name
* `inb_subnet_address_space`- Address space for the Subnet that is created for Inbound Endpoint

## Outputs in `outputs.tf`
* `dns_inbound_endpoint`- Inbound DNS IP configuration
