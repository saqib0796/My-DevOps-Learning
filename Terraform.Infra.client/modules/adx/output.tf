output "adx_cluster_id" {
  value = azurerm_kusto_cluster.adxcluster.id
}
output "adx_database_name"{
  value = azurerm_kusto_database.adxdatabase.name
}

output "adx_connection_string" {
  value = azurerm_kusto_cluster.adxcluster.uri  
}