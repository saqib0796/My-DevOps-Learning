variable "rg_obuoc_name" { }
variable "rg_obuoc_location" { }
variable "tags" { }
variable "suffix" { }
variable "environment" { }
variable "agw_public_ip_address_name" { }
variable "public_ip_allocation_method" { }
variable "public_ip_address_sku" { }
variable "agw_name" { }
variable "app_gateway_sku_name" { }
variable "app_gateway_sku_tier" { }
variable "app_gateway_sku_capacity" { }
variable "appgatway_subnet_id" { }
variable "frontend_port_name" { }
variable "frontend_ip_configuration_name" { }
variable "backend_address_pool_name_webui" { }
variable "webui_app_service_default_site_hostname" { }
variable "backend_address_pool_name_obtsync" { }
variable "obtsync_app_service_default_site_hostname" { }
variable "backend_address_pool_name_timeseries_api" { }
variable "timeseries_api_app_service_default_site_hostname" { }
variable "backend_address_pool_name_graphql_entity" { }
variable "graphql_entity_app_service_default_site_hostname" { }
variable "backend_address_pool_name_graphql_event" { }
variable "graphql_event_app_service_default_site_hostname" { }
variable "backend_address_pool_name_utility" { }
variable "utility_app_service_default_site_hostname" { }
variable "backend_address_pool_name_storage" { }
variable "storage_app_service_default_site_hostname" { }
variable "backend_address_pool_name_eventhub_telemetry" { }
variable "eventhub_telemetry_app_service_default_site_hostname" { }
variable "backend_address_pool_name_eventprocessor" { }
variable "eventprocessor_functionapp_default_site_hostname" { }
variable "backend_http_settings_name_eventprocessor" { }
variable "path_name_eventprocessor" { }
variable "route_eventprocessor" { }
variable "backend_http_settings_name_webui" { }
variable "backend_http_settings_name_obtsync" { }
variable "backend_http_settings_name_timeseries_api" { }
variable "backend_http_settings_name_graphql_entity" { }
variable "backend_http_settings_name_graphql_event" { }
variable "backend_http_settings_name_utility" { }
variable "backend_http_settings_name_storage" { }
variable "backend_http_settings_name_eventhub_telemetry" { }
variable "listener_name" { }
variable "request_routing_rule_name" { }
variable "rule_name" { }
variable "path_name_obtsync" { }
variable "route_obtsync" { }
variable "path_name_graphqlevent" { }
variable "route_graphqlevent" { }
variable "path_name_graphqlentity" { }
variable "route_graphqlentity" { }
variable "path_name_storage" { }
variable "route_storage" { }
variable "path_name_utility" { }
variable "route_utility" { }
variable "path_name_timeseriesapi" { }
variable "route_timeseriesapi" { }
variable "path_name_eventhub_telemetry" { }
variable "route_eventhub_telemetry" { }