output "vnet_id" {
  value = azurerm_virtual_network.obuoc_vnet.id
}

output "appgatway_subnet_id" {
  value = azurerm_subnet.app_gateway_subnet.id
}

output "azureservices_subnet_id" {
  value = azurerm_subnet.azureservices_subnet.id
}

output "linux_app_service_subnet_id" {
  value = azurerm_subnet.linux_app_service_subnet.id
}

output "windows_app_service_subnet_id" {
  value = azurerm_subnet.windows_app_service_subnet.id
}

output "obtsync_app_service_subnet_id" {
  value = azurerm_subnet.obtsync_app_service_subnet.id
}