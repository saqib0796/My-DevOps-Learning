output "ai_instrumentation_key" {
  value = azurerm_application_insights.appinsights.instrumentation_key
}

output "ai_connection_string" {
  value = azurerm_application_insights.appinsights.connection_string
}

output "ai_app_id" {
  value = azurerm_application_insights.appinsights.app_id
}

output "user_audit_ai_instrumentation_key" {
  value = azurerm_application_insights.user_audit_appinsights.instrumentation_key
}

output "user_audit_ai_connection_string" {
  value = azurerm_application_insights.user_audit_appinsights.connection_string
}

output "user_audit_ai_app_id" {
  value = azurerm_application_insights.user_audit_appinsights.app_id
}