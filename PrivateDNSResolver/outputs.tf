output "priv_dns_resolver_id" {
  value = azurerm_private_dns_resolver.pr_dns_resolver.id
}

output "dns_inbound_endpoint" {
  value = azurerm_private_dns_resolver_inbound_endpoint.dns_resolver_inb_endpoint.ip_configurations
}