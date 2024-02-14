output "vnet_id" {
  value = resource.azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  value = resource.azurerm_subnet.subnet.id
}
