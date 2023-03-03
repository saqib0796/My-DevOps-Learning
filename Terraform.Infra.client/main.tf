provider "azurerm" {
  client_id                  = var.terrclient_id
  client_secret              = var.terrclient_secret
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  version                    = "~> 2.95.0"
  features {}
  skip_provider_registration = true
}

terraform {
  backend "azurerm" { }
}

/*data "azurerm_resource_group" "resource_group" {
  name     = var.rg_ob_name
}*/

resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_test_name
  location = var.rg_test_location
  tags     = var.tags
}

data "azurerm_client_config" "current" {}
module "vnet" {
  source                             = ".//modules/vnet"
  suffix                             = var.suffix
  environment                        = var.environment
  tags                               = var.tags
  rg_test_name                      = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location                  = azurerm_resource_group.resource_group.location//var.rg_test_location
  test_vnet_name                    = var.test_vnet_name
  test_vnet_address                 = var.test_vnet_address
  azureservices_subnet_name          = var.azureservices_subnet_name
  azureservices_subnet_address       = var.azureservices_subnet_address
  linux_app_service_subnet_name      = var.linux_app_service_subnet_name
  linux_app_service_subnet_address   = var.linux_app_service_subnet_address
  windows_app_service_subnet_name    = var.windows_app_service_subnet_name
  windows_app_service_subnet_address = var.windows_app_service_subnet_address
  obtsync_app_service_subnet_name    = var.obtsync_app_service_subnet_name
  obtsync_app_service_subnet_address = var.obtsync_app_service_subnet_address
  agw_subnet_name                    = var.agw_subnet_name
  appgw_subnet_address               = var.appgw_subnet_address
}

module "eventhub" {
  source                         = ".//modules/eventhub"
  suffix                         = var.suffix
  environment                    = var.environment
  azureservices_subnet_id        = module.vnet.azureservices_subnet_id
  linux_app_service_subnet_id    = module.vnet.linux_app_service_subnet_id
  windows_app_service_subnet_id  = module.vnet.windows_app_service_subnet_id
  obtsync_app_service_subnet_id  = module.vnet.obtsync_app_service_subnet_id
  appgatway_subnet_id            = module.vnet.appgatway_subnet_id
  azure_eventhub_namespace       = var.azure_eventhub_namespace
  eventhub_sku                   = var.eventhub_sku
  eventhub_capacity              = var.eventhub_capacity
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  eventhub_obtevents_name        = var.eventhub_obtevents_name
  eventhub_telemetry_name        = var.eventhub_telemetry_name
  consumer_group_names_obtevents = var.consumer_group_names_obtevents
  consumer_group_names_telemetry = var.consumer_group_names_telemetry
  eventhub_partition_count       = var.eventhub_partition_count
  eventhub_message_retention     = var.eventhub_message_retention
  tags                           = var.tags
}

module "storageaccount" {
  source                        = ".//modules/storageaccount"
  suffix                        = var.storagesuffix
  environment                   = var.environment
  azureservices_subnet_id       = module.vnet.azureservices_subnet_id
  linux_app_service_subnet_id   = module.vnet.linux_app_service_subnet_id
  windows_app_service_subnet_id = module.vnet.windows_app_service_subnet_id
  obtsync_app_service_subnet_id = module.vnet.obtsync_app_service_subnet_id
  appgatway_subnet_id           = module.vnet.appgatway_subnet_id
  rg_test_name                 = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location             = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags                          = var.tags
  core_storageaccount_name      = var.core_storageaccount_name
  cdn_storageaccount_name       = var.cdn_storageaccount_name
  tsdbtm_storageaccount_name    = var.tsdbtm_storageaccount_name
  core_sa_container_names       = var.core_sa_container_names
  core_sa_event_archive_container_name = var.core_sa_event_archive_container_name
}

module "database" {
  source                           = ".//modules/database"
  suffix                           = var.suffix
  environment                      = var.environment
  rg_test_name                    = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location                = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags                             = var.tags
  azure_entity_postgresql_name     = var.azure_entity_postgresql_name
  postgresql_sku_name              = var.postgresql_sku_name
  postgresql_storage_mb            = var.postgresql_storage_mb
  postgresql_backup_retention_days = var.postgresql_backup_retention_days
  postgresql_geo_redundant_backup  = var.postgresql_geo_redundant_backup
  postgresql_server_version        = var.postgresql_server_version
  postgresql_ssl_enforcement       = var.postgresql_ssl_enforcement
  postgresql_db_names              = var.postgresql_db_names
  postgresql_db_charset            = var.postgresql_db_charset
  postgresql_db_collation          = var.postgresql_db_collation
  azureservices_subnet_id          = module.vnet.azureservices_subnet_id
  linux_app_service_subnet_id      = module.vnet.linux_app_service_subnet_id
  windows_app_service_subnet_id    = module.vnet.windows_app_service_subnet_id
  obtsync_app_service_subnet_id    = module.vnet.obtsync_app_service_subnet_id
  appgatway_subnet_id              = module.vnet.appgatway_subnet_id
  azure_events_postgresql_name     = var.azure_events_postgresql_name
  postgresql_events_db_names       = var.postgresql_events_db_names
  pdb_admin_login_akv_key          = var.pdb_admin_login_akv_key
  pdb_admin_pwd_akv_key            = var.pdb_admin_pwd_akv_key
  prod_replica_resource_group      = var.prod_replica_resource_group
  prod_replica_subscription_id     = var.prod_replica_subscription_id
  prod_replica_environment         = var.prod_replica_environment
  prod_replica_suffix              = var.prod_replica_suffix
  subscription_id	                 = var.subscription_id
  terrclient_secret	               = var.terrclient_secret
  tenant_id 	                     = var.tenant_id
}

module "timeseriesinsights" {
  source                                        = ".//modules/timeseriesinsights"
  suffix                                        = var.suffix
  environment                                   = var.environment
  client_id                                     = var.client_id
  app_name                                      = var.app_name
  rg_test_name                                 = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location                             = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags                                          = var.tags
  time_series_insights_telemetry_name           = var.time_series_insights_telemetry_name
  azure_eventhub_namespace                      = var.azure_eventhub_namespace
  eventhub_telemetry_name                       = var.eventhub_telemetry_name
  consumer_group_names_telemetry                = var.consumer_group_names_telemetry
  event_source_Name                             = var.event_source_Name
  tsdbtm_storageaccount_name                    = module.storageaccount.tsdbtm_storageaccount_name
  tsdbtm_storage_account_primary_access_key     = module.storageaccount.tsdbtm_storage_account_primary_access_key
  eventhub_telemetry_id                         = module.eventhub.eventhub_telemetry_id
  eventhub_telemetry_policy_listen_primary_key  = module.eventhub.eventhub_telemetry_policy_listen_primary_key
}

module "loganalyticsworkspace" {
  source            = ".//modules/loganalyticsworkspace"
  suffix            = var.suffix
  environment       = var.environment
  rg_test_name     = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags              = var.tags
  law_name          = var.law_name
}

module "appinsights" {
  source                      = ".//modules/appinsights"
  suffix                      = var.suffix
  environment                 = var.environment
  rg_test_name               = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location           = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags                        = var.tags
  appinsights_name            = var.appinsights_name
  user_audit_appinsights_name = var.user_audit_appinsights_name
  loganalyticsworkspace_id    = module.loganalyticsworkspace.loganalyticsworkspace_id
}

module "keyvault" {
  source                                 = ".//modules/keyvault"
  suffix                                 = var.suffix
  environment                            = var.environment
  azure_keyvault_name                    = var.azure_keyvault_name
  subscription_id                        = var.subscription_id
  tenant_id                              = data.azurerm_client_config.current.tenant_id
  aad_sp_object_id                       = data.azurerm_client_config.current.object_id
  tags                                   = var.tags
  test_vnet_name                        = var.test_vnet_name
  azureservices_subnet_name              = var.azureservices_subnet_name
  linux_app_service_subnet_name          = var.linux_app_service_subnet_name
  windows_app_service_subnet_name        = var.windows_app_service_subnet_name
  obtsync_app_service_subnet_name        = var.obtsync_app_service_subnet_name
  agw_subnet_name                        = var.agw_subnet_name
  rg_test_name                          = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location                      = azurerm_resource_group.resource_group.location//var.rg_test_location
  ar_app_password                        = var.ar_app_password
  evh_test_obtevents_readonly           = module.eventhub.eventhub_obtevents_policy_listen_primary_connection_string
  evh_test_obtevents_write              = module.eventhub.eventhub_obtevents_policy_send_primary_connection_string
  evh_test_telemetry_readonly           = module.eventhub.eventhub_telemetry_policy_listen_primary_connection_string
  evh_test_telemetry_write              = module.eventhub.eventhub_telemetry_policy_send_primary_connection_string
  open_blue_aad_client_secret            = var.open_blue_aad_client_secret
  pgsql_test_entity_gql_conn_string     = "postgres://${var.pdb_admin_login_akv_key}@${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix}:${var.pdb_admin_pwd_akv_key}@${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix}.postgres.database.azure.com:5432/${var.postgresql_db_names}"
  pgsql_test_entity_obtsync_conn_string = "Host=${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix}.postgres.database.azure.com;Database=${var.postgresql_db_names};Username=${var.pdb_admin_login_akv_key}@${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix};Password=${var.pdb_admin_pwd_akv_key};Ssl Mode=Require;Timeout=60;CommandTimeout=300;"
  pgsql_test_entity_evproc_conn_string  = "Server=${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix}.postgres.database.azure.com;Database=${var.postgresql_db_names};Port=5432;User Id=${var.pdb_admin_login_akv_key}@${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix};Password=${var.pdb_admin_pwd_akv_key};Ssl Mode=Require;Timeout=60;CommandTimeout=300;"
  pgsql_test_events_evproc_conn_string  = "Server=${var.azure_events_postgresql_name}-${var.environment}-${var.suffix}.postgres.database.azure.com;Database=${var.postgresql_events_db_names};Port=5432;User Id=${var.pdb_admin_login_akv_key}@${var.azure_events_postgresql_name}-${var.environment}-${var.suffix};Password=${var.pdb_admin_pwd_akv_key};Ssl Mode=Require;Timeout=60;CommandTimeout=300;"
  pgsql_test_events_gql_conn_string     = "postgres://${var.pdb_admin_login_akv_key}@${var.azure_events_postgresql_name}-${var.environment}-${var.suffix}:${var.pdb_admin_pwd_akv_key}@${var.azure_events_postgresql_name}-${var.environment}-${var.suffix}.postgres.database.azure.com:5432/${var.postgresql_events_db_names}"
  st_uoc_func_conn_string                = module.storageaccount.core_storage_account_primary_conn_string
  st_uoc_cdn_conn_string                 = module.storageaccount.cdn_storage_account_primary_conn_string
  uoc_aad_client_secret                  = var.client_secret
  uoc_forge_secret                       = var.forge_client_secret
  pdb_admin_login_akv_key                = var.pdb_admin_login_akv_key
  pdb_admin_pwd_akv_key                  = var.pdb_admin_pwd_akv_key
  obt_keycloak_password                  = var.obt_keycloak_password
  forge_client_id                        = var.forge_client_id
  forge_client_secret                    = var.forge_client_secret
  autodesk_url                           = var.autodesk_url
  gql_tenantid                           = var.gql_tenantid
  gql_clientid                           = var.gql_clientid
  gql_secret                             = var.gql_secret
  gql_scope                              = var.gql_scope
  gql_url                                = var.gql_url
  az_ad_tenantid                         = var.az_ad_tenantid
  endpoint                               = var.endpoint
  issuer                                 = var.issuer
  valid_audiences                        = var.valid_audiences
  downloadfolderpath                     = var.downloadfolderpath
  gqlclienttimeout                       = var.gqlclienttimeout
  ai_instrumentationkey                  = module.appinsights.ai_instrumentation_key
  uoc_maptiler_map_conn_str              = var.uoc_maptiler_map_conn_str
  uoc_maptiler_tile_conn_str             = var.uoc_maptiler_tile_conn_str
}

module "maps" {
  source         = ".//modules/maps"
  suffix         = var.suffix
  environment    = var.environment
  rg_test_name  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags           = var.tags
}

module "signalr" {
  source            = ".//modules/signalr"
  suffix            = var.suffix
  environment       = var.environment
  rg_test_name     = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags              = var.tags
}

module "appservices" {
  source                                  = ".//modules/appservices"
  suffix                                  = var.suffix
  environment                             = var.environment
  rg_test_name                           = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location                       = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags                                    = var.tags
  keyvault_id                             = module.keyvault.keyvault.id
  linux_app_service_plan_name             = var.linux_app_service_plan_name
  windows_app_service_plan_name           = var.windows_app_service_plan_name
  obtsync_app_service_plan_name           = var.obtsync_app_service_plan_name
  obtsync_app_service_name                = var.obtsync_app_service_name
  windows_app_service_subnet_id           = module.vnet.windows_app_service_subnet_id
  obtsync_app_service_subnet_id           = module.vnet.obtsync_app_service_subnet_id
  webui_app_service_name                  = var.webui_app_service_name
  graphql_entity_app_service_name         = var.graphql_entity_app_service_name
  appgatway_subnet_id                     = module.vnet.appgatway_subnet_id
  azureservices_subnet_id                 = module.vnet.azureservices_subnet_id
  linux_app_service_subnet_id             = module.vnet.linux_app_service_subnet_id
  graphql_event_app_service_name          = var.graphql_event_app_service_name
  timeseries_api_app_service_name         = var.timeseries_api_app_service_name
  utility_app_service_name                = var.utility_app_service_name
  windows_function_app_name               = var.windows_function_app_name
  core_storageaccount_name                = module.storageaccount.core_storageaccount_name
  core_storage_account_primary_access_key = module.storageaccount.core_storage_account_primary_access_key
  ai_instrumentation_key                  = module.appinsights.ai_instrumentation_key
  ai_connection_string                    = module.appinsights.ai_connection_string
  client_id                               = var.client_id
  tenant_id                               = var.tenant_id
  client_secret                           = var.client_secret
  ercollection_id                         = var.ercollection_id
  ping_utility_ercollectionid             = var.ping_utility_ercollectionid
  ob_client_id                            = var.ob_client_id
  ob_graphql_id                           = var.ob_graphql_id
  ob_scope                                = var.ob_scope
  ob_secret                               = "${module.keyvault.keyvault.vault_uri}secrets/open-blue-aad-client-secret/${module.keyvault.ob_secret}"//module.keyvault.ob_secret
  ob_tenant_id                            = var.ob_tenant_id
  pg_connection_string                    = "${module.keyvault.keyvault.vault_uri}secrets/pgsql-test-entity-obtsync-conn-string/${module.keyvault.pg_connection_string}"//module.keyvault.pg_connection_string
  subscription_id                         = var.obt_subscription_id
  website_dns_server                      = var.website_dns_server
  obt_keycloak_client_id                  = var.obt_keycloak_client_id
  obt_keycloak_login_host                 = var.obt_keycloak_login_host
  obt_keycloak_password                   = "${module.keyvault.keyvault.vault_uri}secrets/open-blue-keycloak-password/${module.keyvault.obt_keycloak_password}"//module.keyvault.obt_keycloak_password
  obt_keycloak_realm                      = var.obt_keycloak_realm
  obt_keycloak_username                   = var.obt_keycloak_username
  uoc_core_sa_conn_string                 = "${module.keyvault.keyvault.vault_uri}secrets/st-uoc-func-conn-string/${module.keyvault.uoc_core_sa_conn_string}"//module.keyvault.uoc_core_sa_conn_string 
  core_sa_container_names                 = var.core_sa_container_names
  forge_auth_url                          = var.forge_auth_url
  audience                                = var.audiences
  entity_db_url                           = "${module.keyvault.keyvault.vault_uri}secrets/pgsql-test-entity-gql-conn-string/${module.keyvault.entity_db_url}"//module.keyvault.entity_db_url
  event_db_url                            = "${module.keyvault.keyvault.vault_uri}secrets/pgsql-test-events-gql-conn-string/${module.keyvault.event_db_url}"//module.keyvault.event_db_url
  issuer_uri                              = var.issuer
  jwks_uri                                = var.jwks_uri
  az_ts_fqdn                              = module.timeseriesinsights.az_ts_fqdn
  msal_tenant_id                          = var.msal_tenant_id
  msal_client_id                          = var.msal_client_id
  msal_client_secret                      = "${module.keyvault.keyvault.vault_uri}secrets/uoc-aad-client-secret/${module.keyvault.msal_client_secret}"//module.keyvault.msal_client_secret
  msal_ts_scope                           = var.msal_ts_scope
  ar_keycloak_url                         = var.ar_keycloak_url
  forge_client_id                         = var.forge_client_id
  forge_secret                            = "${module.keyvault.keyvault.vault_uri}secrets/uoc-forge-secret/${module.keyvault.forge_secret}"//module.keyvault.forge_secret
  ar_tenant_url                           = var.ar_tenant_url
  ar_app_username                         = var.ar_app_username
  ar_app_password                         = "${module.keyvault.keyvault.vault_uri}secrets/ar-app-password/${module.keyvault.ar_app_password}"//module.keyvault.ar_app_password
  ar_client_id                            = var.ar_client_id
  ar_sop_service_url                      = var.ar_sop_service_url
  ar_sop_service_new_url                  = var.ar_sop_service_new_url
  obt_msal_client_id                      = var.msal_client_id
  obt_graphql_url                         = var.obt_graphql_url
  obt_subscription_id                     = var.obt_subscription_id
  evh_test_obtevents_readonly            = "${module.keyvault.keyvault.vault_uri}secrets/evh-test-obtevents-readonly/${module.keyvault.evh_test_obtevents_readonly}"//module.keyvault.evh_test_obtevents_readonly
  ob_consumer_group                       = var.ob_consumer_group
  ob_eventhub                             = var.ob_eventhub
  evh_test_telemetry_readonly            = "${module.keyvault.keyvault.vault_uri}secrets/evh-test-telemetry-readonly/${module.keyvault.evh_test_telemetry_readonly}"//module.keyvault.evh_test_telemetry_readonly
  evh_test_telemetry_write               = "${module.keyvault.keyvault.vault_uri}secrets/evh-test-telemetry-write/${module.keyvault.evh_test_telemetry_write}"//module.keyvault.evh_test_telemetry_write
  telemetryeventhubname                   = "${var.eventhub_telemetry_name}-${var.environment}-${var.suffix}"
  pgsql_test_entity_evproc_conn_string   = "${module.keyvault.keyvault.vault_uri}secrets/pgsql-test-entity-evproc-conn-string/${module.keyvault.pgsql_test_entity_evproc_conn_string}"//module.keyvault.pgsql_test_entity_evproc_conn_string
  pgsql_test_events_evproc_conn_string   = "${module.keyvault.keyvault.vault_uri}secrets/pgsql-test-events-evproc-conn-string/${module.keyvault.pgsql_test_events_evproc_conn_string}"//module.keyvault.pgsql_test_events_evproc_conn_string
  endpoint                                = "${module.keyvault.keyvault.vault_uri}secrets/Endpoint/${module.keyvault.endpoint}"//module.keyvault.endpoint
  issuer                                  = "${module.keyvault.keyvault.vault_uri}secrets/Issuer/${module.keyvault.issuer}"//module.keyvault.issuer
  valid_audiences                         = var.audiences
  signalr_connection_string               = module.signalr.signalr_primary_connection_string
  adx_app_id                              = var.adx_app_id
  adx_connection_string                   = module.adx.adx_connection_string
  uoc_maptiler_tile_conn_str              = "${module.keyvault.keyvault.vault_uri}secrets/uoc-maptiler-tile-conn-str/${module.keyvault.uoc_maptiler_tile_conn_str}"//module.keyvault.uoc_maptiler_tile_conn_str
  uoc_maptiler_map_conn_str               = "${module.keyvault.keyvault.vault_uri}secrets/uoc-maptiler-map-conn-str/${module.keyvault.uoc_maptiler_map_conn_str}"//module.keyvault.uoc_maptiler_map_conn_str
  azurerm_kusto_database_name             = module.adx.adx_database_name
  uoc_memeber_of_api_url                  = var.uoc_memeber_of_api_url
  sxs_graphql_url                         = var.sxs_graphql_url
 /* dev_cors_url                            = var.dev_cors_url
  test_cors_url                           = var.test_cors_url
  stage_cors_url                          = var.stage_cors_url
  prod_cors_url                           = var.prod_cors_url*/
  app_log_utility_url                     = var.app_log_utility_url
  windows_function_app_names              = var.windows_function_app_names
  ob_consumer_groups                      = var.ob_consumer_groups
  ob_eventhubs                            = var.ob_eventhubs
  cors_url                                = var.cors_url
  core_sa_event_archive_container_name    = var.core_sa_event_archive_container_name
  BOTNOTCH_ENDPOINT_FOR_EVENTS            = var.BOTNOTCH_ENDPOINT_FOR_EVENTS
  BOTNOTCH_ENDPOINT_FOR_TURNSTILE_DETAILS = var.BOTNOTCH_ENDPOINT_FOR_TURNSTILE_DETAILS
  BOTNOTCH_API_BEARER_TOKEN               = var.BOTNOTCH_API_BEARER_TOKEN
  obt_event_graphql_url                   = var.obt_event_graphql_url
  obt_event_gql_url                       = var.obt_event_gql_url
  uoc_msal_tenant_id                      = var.uoc_msal_tenant_id
  uoc_msal_client_id                      = var.uoc_msal_client_id
  uoc_msal_client_secret                  = var.uoc_msal_client_secret
  uoc_msal_scope                          = var.uoc_msal_scope
}

module "applicationgateway" {
  source                                               = ".//modules/applicationgateway"
  suffix                                               = var.suffix
  environment                                          = var.environment
  rg_test_name                                        = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location                                    = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags                                                 = var.tags
  agw_public_ip_address_name                           = var.agw_public_ip_address_name
  public_ip_allocation_method                          = var.public_ip_allocation_method
  public_ip_address_sku                                = var.public_ip_address_sku
  agw_name                                             = var.agw_name
  app_gateway_sku_name                                 = var.app_gateway_sku_name
  app_gateway_sku_tier                                 = var.app_gateway_sku_tier
  app_gateway_sku_capacity                             = var.app_gateway_sku_capacity
  appgatway_subnet_id                                  = module.vnet.appgatway_subnet_id
  frontend_port_name                                   = "${var.agw_name}-frontend-port"
  frontend_ip_configuration_name                       = "${var.agw_name}-frontend-ip"
  backend_address_pool_name_webui                      = "${var.agw_name}-backend-pool-webui"
  webui_app_service_default_site_hostname              = module.appservices.webui_app_service.default_site_hostname
  backend_address_pool_name_obtsync                    = "${var.agw_name}-backend-pool-obtsync"
  obtsync_app_service_default_site_hostname            = module.appservices.obtsync_app_service.default_site_hostname
  backend_address_pool_name_timeseries_api             = "${var.agw_name}-backend-pool-timeseries"
  timeseries_api_app_service_default_site_hostname     = module.appservices.timeseries_api_app_service.default_site_hostname
  backend_address_pool_name_graphql_entity             = "${var.agw_name}-backend-pool-entity"
  graphql_entity_app_service_default_site_hostname     = module.appservices.graphql_entity_app_service.default_site_hostname
  backend_address_pool_name_graphql_event              = "${var.agw_name}-backend-pool-event"
  graphql_event_app_service_default_site_hostname      = module.appservices.graphql_event_app_service.default_site_hostname
  backend_address_pool_name_utility                    = "${var.agw_name}-backend-pool-utility"
  utility_app_service_default_site_hostname            = module.appservices.utility_app_service.default_site_hostname
  backend_address_pool_name_storage                    = "${var.agw_name}-backend-pool-storagecdn"
  storage_app_service_default_site_hostname            = "${var.cdn_storageaccount_name}${var.environment}${var.suffix}.z6.web.core.windows.net"
  backend_address_pool_name_eventhub_telemetry         = "${var.agw_name}-backend-pool-eventhub-telemetry"
  eventhub_telemetry_app_service_default_site_hostname = "${var.azure_eventhub_namespace}.servicebus.windows.net"
  backend_address_pool_name_eventprocessor             = "${var.agw_name}-backend-pool-eventprocessor"
  eventprocessor_functionapp_default_site_hostname     = module.appservices.windows_functions.default_hostname
  backend_http_settings_name_webui                     = "${var.agw_name}-backend-http-webui"
  backend_http_settings_name_obtsync                   = "${var.agw_name}-backend-http-obtsync"
  backend_http_settings_name_timeseries_api            = "${var.agw_name}-backend-http-timeseries"
  backend_http_settings_name_graphql_entity            = "${var.agw_name}-backend-http-entity"
  backend_http_settings_name_graphql_event             = "${var.agw_name}-backend-http-event"
  backend_http_settings_name_utility                   = "${var.agw_name}-backend-http-utility"
  backend_http_settings_name_storage                   = "${var.agw_name}-backend-http-storagecdn"
  backend_http_settings_name_eventhub_telemetry        = "${var.agw_name}-backend-http-eventhub-telemetry"
  backend_http_settings_name_eventprocessor            = "${var.agw_name}-backend-http-eventprocessor"
  listener_name                                        = "${var.agw_name}-listener"
  request_routing_rule_name                            = "${var.agw_name}-routing-rule"
  rule_name                                            = "${var.agw_name}-rule"
  path_name_obtsync                                    = "${var.agw_name}-obtsync"
  route_obtsync                                        = var.route_obtsync
  path_name_graphqlevent                               = "${var.agw_name}-event"
  route_graphqlevent                                   = var.route_graphqlevent
  path_name_graphqlentity                              = "${var.agw_name}-entity"
  route_graphqlentity                                  = var.route_graphqlentity
  path_name_storage                                    = "${var.agw_name}-storagecdn"
  route_storage                                        = var.route_storage
  path_name_utility                                    = "${var.agw_name}-utility"
  route_utility                                        = var.route_utility
  path_name_timeseriesapi                              = "${var.agw_name}-timeseries"
  route_timeseriesapi                                  = var.route_timeseriesapi
  path_name_eventhub_telemetry                         = "${var.agw_name}-eventhub-telemetry"
  route_eventhub_telemetry                             = var.route_eventhub_telemetry
  path_name_eventprocessor                             = "${var.agw_name}-eventprocessor"
  route_eventprocessor                                 = var.route_eventprocessor
}

module "dns" {
  source          = ".//modules/dns"
  rg_test_name   = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags            = var.tags
  storage_zone    = var.storage_zone
  vnet_id         = module.vnet.vnet_id
  app_zone        = var.app_zone
  keyvault_zone   = var.keyvault_zone
  postgresql_zone = var.postgresql_zone
  eventhub_zone   = var.eventhub_zone
  kusto_zone      = var.kusto_zone
}

module "function-private-endpoint-windows-function" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.windows_function_app_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_app_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.function_subresource_names
  private_connection_resource_id = module.appservices.windows_functions.id
}

module "function-private-endpoint-windows-function-test" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.windows_function_app_names
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_app_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.function_subresource_names
  private_connection_resource_id = module.appservices.windows_functions_test.id
}

module "obtsync_app_service-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.obtsync_app_service_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_app_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.function_subresource_names
  private_connection_resource_id = module.appservices.obtsync_app_service.id
}

module "webui_app_service-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.webui_app_service_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_app_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.function_subresource_names
  private_connection_resource_id = module.appservices.webui_app_service.id
}

module "graphql_event_app_service-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.graphql_event_app_service_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_app_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.function_subresource_names
  private_connection_resource_id = module.appservices.graphql_event_app_service.id
}

module "graphql_entity_app_service-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.graphql_entity_app_service_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_app_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.function_subresource_names
  private_connection_resource_id = module.appservices.graphql_entity_app_service.id
}

module "timeseries_api_app_service-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.timeseries_api_app_service_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_app_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.function_subresource_names
  private_connection_resource_id = module.appservices.timeseries_api_app_service.id
}

module "utility_app_service-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.utility_app_service_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_app_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.function_subresource_names
  private_connection_resource_id = module.appservices.utility_app_service.id
}

module "postgresql-entity-private-endpoint" {
  count = var.rg_test_location == "westeurope" ? 1 : 0
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.azure_entity_postgresql_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_ps_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.postgresql_subresource_names
  private_connection_resource_id = module.database.postgresql_entity[0].id
}

module "postgresql-events-private-endpoint" {
  count = var.rg_test_location == "westeurope" ? 1 : 0
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.azure_events_postgresql_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_ps_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.postgresql_subresource_names
  private_connection_resource_id = module.database.postgresql_events[0].id
}


module "keyvault-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.azure_keyvault_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_kv_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.key_vault_subresource_names
  private_connection_resource_id = module.keyvault.keyvault.id
}

module "eventhub-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.azure_eventhub_namespace
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_eh_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.event_hub_subresource_names
  private_connection_resource_id = module.eventhub.eventhub.id
}

module "signalr-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.azure_signalr_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_eh_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.signalr_subresource_names
  private_connection_resource_id = module.signalr.signalr_service_id
}

module "storage_accounnt-coresa" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  for_each                       = var.fn_storage_subresource_names
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = "${var.core_storageaccount_name}-${each.value}"
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_sa_id[each.key].id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = each.value
  private_connection_resource_id = module.storageaccount.storageaccountcoresa.id
}

module "storage_accounnt-cdnsa" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  for_each                       = var.fn_storage_subresource_names
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = "${var.cdn_storageaccount_name}-${each.value}"
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_sa_id[each.key].id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = each.value
  private_connection_resource_id = module.storageaccount.storageaccountcdnsa.id
}

module "vm" {
  source                   = ".//modules/vm"
  suffix                   = var.suffix
  environment              = var.environment
  rg_test_name            = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location        = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags                     = var.tags
  azureservices_subnet_id  = module.vnet.azureservices_subnet_id
  vm_size                  = var.vm_size
  vm_storage_acc_type      = var.vm_storage_acc_type
  vm_adminuser             = var.vm_adminuser
}

module "adx" {
  source                                = ".//modules/adx"
  suffix                                = var.suffix
  environment                           = var.environment
  rg_test_name                         = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location                     = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags                                  = var.tags
  azurerm_kusto_cluster_name            = var.azurerm_kusto_cluster_name
  adx_sku_name_size                     = var.adx_sku_name_size
  azurerm_kusto_database_name           = var.azurerm_kusto_database_name
  eventhub_ns_name                      = var.eventhub_ns_name
  eventhub_name                         = var.eventhub_name
  consumer_group_name                   = var.consumer_group_name
  eventhub_connection_name              = var.eventhub_connection_name
  eventhub_telemetery_id                = module.eventhub.eventhub_telemetry_id
  eventhub_consumergroup_telemetery_2   = module.eventhub.eventhub_telemetery_2
}

module "adx-private-endpoint" {
  source                         = ".//modules/privateendpoint"
  suffix                         = var.suffix
  environment                    = var.environment
  rg_test_name                  = azurerm_resource_group.resource_group.name//var.rg_test_name
  tags                           = var.tags
  endpointname                   = var.azurerm_kusto_cluster_name
  subnet_id                      = module.vnet.azureservices_subnet_id
  private_dns_zone_ids           = module.dns.privateLink_kusto_id
  rg_test_location              = azurerm_resource_group.resource_group.location//var.rg_test_location
  subresource_names              = var.adx_subresource_names
  private_connection_resource_id = module.adx.adx_cluster_id
}

module "databasereplica" {
  source                           = ".//modules/databasereplica"
  suffix                           = var.suffix
  environment                      = var.environment
 subscription_id                        = var.subscription_id
  rg_test_name                    = azurerm_resource_group.resource_group.name//var.rg_test_name
  rg_test_location                = azurerm_resource_group.resource_group.location//var.rg_test_location
  tags                             = var.tags
  azure_entity_postgresql_name     = var.azure_entity_postgresql_name
  postgresql_sku_name              = var.postgresql_sku_name
  postgresql_storage_mb            = var.postgresql_storage_mb
  postgresql_backup_retention_days = var.postgresql_backup_retention_days
  postgresql_geo_redundant_backup  = var.postgresql_geo_redundant_backup
  postgresql_server_version        = var.postgresql_server_version
  postgresql_ssl_enforcement       = var.postgresql_ssl_enforcement
  postgresql_db_names              = var.postgresql_db_names
  postgresql_db_charset            = var.postgresql_db_charset
  postgresql_db_collation          = var.postgresql_db_collation
  azureservices_subnet_id          = module.vnet.azureservices_subnet_id
  linux_app_service_subnet_id      = module.vnet.linux_app_service_subnet_id
  windows_app_service_subnet_id    = module.vnet.windows_app_service_subnet_id
  obtsync_app_service_subnet_id    = module.vnet.obtsync_app_service_subnet_id
  appgatway_subnet_id              = module.vnet.appgatway_subnet_id
  azure_events_postgresql_name     = var.azure_events_postgresql_name
  postgresql_events_db_names       = var.postgresql_events_db_names
  pdb_admin_login_akv_key          = var.pdb_admin_login_akv_key
  pdb_admin_pwd_akv_key            = var.pdb_admin_pwd_akv_key
  prod_replica_resource_group      = var.prod_replica_resource_group
  prod_replica_subscription_id     = var.prod_replica_subscription_id
  prod_replica_environment         = var.prod_replica_environment
  prod_replica_suffix              = var.prod_replica_suffix
  //subscription_id	                 = var.subscription_id
  terrclient_secret	               = var.terrclient_secret
  tenant_id 	                     = var.tenant_id
depends_on = [ module.appinsights, module.applicationgateway, module.appservices, module.database, module.dns, module.eventhub, module.keyvault, module.loganalyticsworkspace, module.maps, module.storageaccount, module.vm, module.vnet]
  //depends_on = [ module.database]
}