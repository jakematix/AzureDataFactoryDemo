output "rg_out_name" {
  value = azurerm_resource_group.rg.name
}

output "rg_id" {
  value = azurerm_resource_group.rg.id
}

output "kv_secrets_id" {
  value = azuread_group.kv_secrets_officers_group.id
}