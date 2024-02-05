output "data_factory_id" {
  value       = azurerm_data_factory.datafactory.identity.0.principal_id
  description = "Data Factory Id"
}