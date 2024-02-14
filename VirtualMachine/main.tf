#Create Public IP Address
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.vm_name}-publicip"
  resource_group_name = var.rg_name
  location            = var.region
  allocation_method   = "Dynamic"
}

data "azurerm_public_ip" "public_ip_address" {
  name                = azurerm_public_ip.vm_public_ip.name
  resource_group_name = var.rg_name
}

# Create network interface in the given subnet
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.region
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.vm_name}-nic-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

# Create a Virtual Machine
resource "azurerm_windows_virtual_machine" "vm" {
  name                       = var.vm_name
  resource_group_name        = var.rg_name
  location                   = var.region
  size                       = var.vm_size
  admin_username             = var.vm_admin_username
  admin_password             = var.vm_admin_password
  network_interface_ids      = [
    azurerm_network_interface.vm_nic.id,
  ]
  patch_mode                 = "AutomaticByPlatform"
  patch_assessment_mode      = "ImageDefault"
  hotpatching_enabled        = true
  allow_extension_operations = true

  os_disk {
    caching                  = "ReadWrite"
    storage_account_type     = "Premium_LRS"
  }

  source_image_reference {
    publisher                = "MicrosoftWindowsServer"
    offer                    = "WindowsServer"
    sku                      = "2022-datacenter-azure-edition-core-smalldisk"
    version                  = "latest"
  }
}

# Enable OpenSSH extension set for the VM
resource "azurerm_virtual_machine_extension" "openssh_ext_set" {
  name                 = "WindowsOpenSSH"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.OpenSSH"
  type                 = "WindowsOpenSSH"
  type_handler_version = "3.0"
}

