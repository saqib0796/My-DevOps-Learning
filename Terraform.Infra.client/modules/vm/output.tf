output "azdeployvm2_id" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine_azdeployvm2.id
}

output "windowscheck_id" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine_windowscheck.id
}

output "network_interface_azdeployvm2_id" {
  value = azurerm_network_interface.network_interface_azdeployvm2.id
}

output "network_interface_windowscheck_id" {
  value = azurerm_network_interface.network_interface_windowscheck.id
}