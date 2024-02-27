# Creation of the Network Security Group, Virtual Network (VNet) and Subnet


resource "azurerm_network_security_group" "nsg" {
  name                = "${var.subnet_name}NSG"
  location            = var.region
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.region
  resource_group_name = var.rg_name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.vnet_subnet_address_space]
}