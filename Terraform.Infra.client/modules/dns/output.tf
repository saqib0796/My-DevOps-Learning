output "privateLink_sa_id" {
  value = azurerm_private_dns_zone.storageAccount
}

output "privateLink_app_id" {
  value = azurerm_private_dns_zone.appservice.id
}

output "privateLink_kv_id" {
  value = azurerm_private_dns_zone.keyVault.id
}

output "privateLink_ps_id" {
  value = azurerm_private_dns_zone.postgresql.id
}

output "privateLink_eh_id" {
  value = azurerm_private_dns_zone.eventHub.id
}

output "privateLink_kusto_id" {
  value = azurerm_private_dns_zone.kusto.id
}