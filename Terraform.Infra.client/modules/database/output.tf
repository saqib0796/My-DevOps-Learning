output "postgresql_entity" {
  value = try(azurerm_postgresql_server.entity_server,"replacereplica")
}

output "postgresql_entity_fqdn" {
  value = try(azurerm_postgresql_server.entity_server[0].fqdn,"replacereplica")
}

output "postgresql_entity_id" {
  value = try(azurerm_postgresql_server.entity_server[0].id,"replacereplica")
}

output "postgresql_events" {
  value = try(azurerm_postgresql_server.events_server, "data.local_file.replica_output.content")
}

output "postgresql_events_fqdn" {
  value = try(azurerm_postgresql_server.events_server[0].fqdn,"fqdnname")
}


