output "windows_functions" {
  value = azurerm_function_app.windows_function_app
}

output "obtsync_app_service" {
  value = azurerm_app_service.obtsync_app_service
}

output "webui_app_service" {
  value = azurerm_app_service.webui_app_service
}

output "graphql_event_app_service" {
  value = azurerm_app_service.graphql_event_app_service
}

output "graphql_entity_app_service" {
  value = azurerm_app_service.graphql_entity_app_service
}

output "timeseries_api_app_service" {
  value = azurerm_app_service.timeseries_api_app_service
}

output "utility_app_service" {
  value = azurerm_app_service.utility_app_service
}

output "windows_functions_test" {
  value = azurerm_function_app.windows_function_apps
}