output "DataFactoryId" {
  value = azurerm_data_factory.datafactory.identity.0.principal_id
}