resource "azurerm_resource_group" "rg" {
  name     = "${var.name_construct}RG"
  location = var.region
}