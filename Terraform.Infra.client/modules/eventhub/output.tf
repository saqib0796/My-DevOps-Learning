output "eventhub_telemetry_id" {
  value = azurerm_eventhub.eventhub_telemetry.id
}

output "eventhub_telemetery_2" {
  value = azurerm_eventhub_consumer_group.consumer_group_telemetry_2.name
}

output "eventhub_obtevents_id" {
  value = azurerm_eventhub.eventhub_obtevents.id
}

output "eventhub_telemetry_policy_send_primary_key" {
  value = azurerm_eventhub_authorization_rule.eventhub_telemetry_policy_send.primary_key
}

output "eventhub_obtevents_policy_send_primary_key" {
  value = azurerm_eventhub_authorization_rule.eventhub_obtevents_policy_send.primary_key
}

output "eventhub_telemetry_policy_listen_primary_key" {
  value = azurerm_eventhub_authorization_rule.eventhub_telemetry_policy_listen.primary_key
}

output "eventhub_obtevents_policy_listen_primary_key" {
  value = azurerm_eventhub_authorization_rule.eventhub_obtevents_policy_listen.primary_key
}

output "eventhub" {
  value = azurerm_eventhub_namespace.evhns
}

output "eventhub_telemetry_policy_send_primary_connection_string" {
  value = azurerm_eventhub_authorization_rule.eventhub_telemetry_policy_send.primary_connection_string
}

output "eventhub_obtevents_policy_send_primary_connection_string" {
  value = azurerm_eventhub_authorization_rule.eventhub_obtevents_policy_send.primary_connection_string
}

output "eventhub_telemetry_policy_listen_primary_connection_string" {
  value = azurerm_eventhub_authorization_rule.eventhub_telemetry_policy_listen.primary_connection_string
}

output "eventhub_obtevents_policy_listen_primary_connection_string" {
  value = azurerm_eventhub_authorization_rule.eventhub_obtevents_policy_listen.primary_connection_string
}