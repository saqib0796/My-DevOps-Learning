output "signalr_service_id" {
  value = azurerm_signalr_service.signalr_service.id
}

output "signalr_primary_connection_string" {
  value = azurerm_signalr_service.signalr_service.primary_connection_string
}

output "signalr_primary_access_key" {
  value = azurerm_signalr_service.signalr_service.primary_access_key
}

output "signalr_secondary_connection_string" {
  value = azurerm_signalr_service.signalr_service.secondary_connection_string
}

output "signalr_secondary_access_key" {
  value = azurerm_signalr_service.signalr_service.secondary_access_key
}