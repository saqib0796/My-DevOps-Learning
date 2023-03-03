output "maps_id" {
  value = azurerm_maps_account.maps_account.id
}

output "maps_primary_access_key" {
  value = azurerm_maps_account.maps_account.primary_access_key
}

output "maps_secondary_access_key" {
  value = azurerm_maps_account.maps_account.secondary_access_key
}