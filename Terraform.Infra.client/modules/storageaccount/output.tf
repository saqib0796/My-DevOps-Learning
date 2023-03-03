output "core_storageaccount_name" {
  value = azurerm_storage_account.core_sa.name
}

output "core_storage_account_primary_access_key" {
  value = azurerm_storage_account.core_sa.primary_access_key
}

output "core_storage_account_primary_conn_string" {
  value = azurerm_storage_account.core_sa.primary_connection_string
}

output "cdn_storage_account_primary_conn_string" {
  value = azurerm_storage_account.cdn_sa.primary_connection_string
}

output "tsdbtm_storageaccount_name" {
  value = azurerm_storage_account.tsdbtm.name
}

output "tsdbtm_storage_account_primary_access_key" {
  value = azurerm_storage_account.tsdbtm.primary_access_key
}

output "storageaccountcoresa" {
  value = azurerm_storage_account.core_sa
}

output "storageaccountcdnsa" {
  value = azurerm_storage_account.cdn_sa
}

output "storageacctsdbtm" {
  value = azurerm_storage_account.tsdbtm
}