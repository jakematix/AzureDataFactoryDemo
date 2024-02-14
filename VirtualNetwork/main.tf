# Creation of the Network Security Group, Virtual Network (VNet) and Subnet


resource "azurerm_network_security_group" "nsg" {
  name                = "${var.subnet_name}NSG"
  location            = var.region
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_rule" "allow_rdp" {
  name                        = "Allow3389"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = var.allowed_ip_address
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "Allow22"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.allowed_ip_address
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}



resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.region
  resource_group_name = var.rg_name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "subnet" {
    name = var.subnet_name
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [var.vnet_subnet_address_space]
}