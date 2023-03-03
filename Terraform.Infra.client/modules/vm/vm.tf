
resource "azurerm_network_interface" "network_interface_azdeployvm2" {
  name                 = "network-interface-azdeployvm2-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name

  ip_configuration {
    name                          = "network-interface-configuration-azdeployvm2-${var.environment}-${var.suffix}"
    subnet_id                     = var.azureservices_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  tags  = var.tags
}


resource "azurerm_linux_virtual_machine" "linux_virtual_machine_azdeployvm2" {
  depends_on = [azurerm_network_interface.network_interface_azdeployvm2]
  name                       = "azdeployvm2-${var.environment}-${var.suffix}"
  location                   = var.rg_obuoc_location
  resource_group_name        = var.rg_obuoc_name
  network_interface_ids      = [azurerm_network_interface.network_interface_azdeployvm2.id,]
  size                       = var.vm_size
  disable_password_authentication = false

  os_disk {
    name                 = "os-disk-azdeployvm2-${var.environment}-${var.suffix}"
    caching              = "None"
    storage_account_type = var.vm_storage_acc_type
  }

  identity {
      type = "SystemAssigned"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name  = "linux-${var.environment}"
  admin_username = "${var.vm_adminuser}-${var.environment}"
  admin_password = "P@$$w0rd1234!"
  tags           = var.tags
}


resource "azurerm_network_interface" "network_interface_windowscheck" {
  name                 = "network-interface-windowscheck-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name

  ip_configuration {
    name                          = "network-interface-configuration-windowscheck-${var.environment}-${var.suffix}"
    subnet_id                     = var.azureservices_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  tags  = var.tags
}


resource "azurerm_windows_virtual_machine" "windows_virtual_machine_windowscheck" {
  depends_on = [azurerm_network_interface.network_interface_windowscheck]
  name                       = "windowscheck-${var.environment}-${var.suffix}"
  location                   = var.rg_obuoc_location
  resource_group_name        = var.rg_obuoc_name
  network_interface_ids      = [azurerm_network_interface.network_interface_windowscheck.id,]
  size                       = var.vm_size
  admin_username             = "${var.vm_adminuser}-${var.environment}"
  admin_password             = "P@$$w0rd1234!"

  os_disk {
    name                 = "os-disk-windowscheck-${var.environment}-${var.suffix}"
    caching              = "None"
    storage_account_type = var.vm_storage_acc_type
  }

  identity {
      type = "SystemAssigned"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  computer_name  = "win-${var.environment}"
  tags = var.tags
}



