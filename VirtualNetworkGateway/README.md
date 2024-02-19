# Module: VirtualNetworkGateway
Creates Virtual Network Gatway to provide access to on-premise. Connection is Point-to-Site. 
Creates
* Gatway subnet to the given Virtual Network
* Public IP address
* Virtual Network Gateway with Client configuration. Authentication type is Azure Certificate and VPN protocols are OpenSSH & IKEv2.

## Variables (inputs) in `variables.tf`
* `rg_name` - Resource Group name
* `region` - Azure Region
* `vnet_gateway_subnet_address_space` - Address space for Gateway subnet
* `vnet_name` - Virtual Network name
* `p2s_address_pool` - Point-to-Site address pool
