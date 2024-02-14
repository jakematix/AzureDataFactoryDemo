output "vm_public_ip" {
  value = data.azurerm_public_ip.public_ip_address.ip_address
}

output "vm_name" {
  value = azurerm_windows_virtual_machine.vm.name
}