# Creates Private DNS Resolver that is needed to access the system from On-premises

resource "azurerm_private_dns_resolver" "pr_dns_resolver" {
  name                = "DNSPrivateResolver"
  resource_group_name = var.rg_name
  location            = var.region
  virtual_network_id  = var.vnet_id
}

# Create a Subnet for the Inbound Endpoiny
resource "azurerm_subnet" "inbound_endpoint_subnet" {
  name                 = "InboundDNS"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.inb_subnet_address_space]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

# Create Inbound Endpoint to the Private DNS Resolver
resource "azurerm_private_dns_resolver_inbound_endpoint" "dns_resolver_inb_endpoint" {
  name                    = "Dns-Inbound-Endpoint"
  private_dns_resolver_id = azurerm_private_dns_resolver.pr_dns_resolver.id
  location                = var.region
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.inbound_endpoint_subnet.id
  }
}