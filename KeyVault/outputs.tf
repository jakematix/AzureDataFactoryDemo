output "azure_kv_id" {
  value = resource.azurerm_key_vault.azure_kv.id
}

output "azure_kv_name" {
  value = resource.azurerm_key_vault.azure_kv.name
}
