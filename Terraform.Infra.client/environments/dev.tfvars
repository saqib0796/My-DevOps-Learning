//rg_obuoc_name = "terraform-rg"
//rg_obuoc_location = "West Europe"
tags            = {"Source"  = "Terraform", "Contact" = "jci-ds-support@jci.com", "Env" = "dev", "Owner" = "JCI", "Product" = "UOC", "Release_Manifest" = "R2.3.0"}
//cli_tags            = "Source=Terraform Contact=jci-ds-support@jci.com Env=dev Owner=JCI Product=UOC Release_Manifest=R2.3.0"
//azure_keyvault_name = "akvobuoc"
azure_eventhub_namespace = "evhns-obuoc"
eventhub_sku = "Standard"
eventhub_capacity = 2
eventhub_partition_count       = 3
eventhub_message_retention     = 3
eventhub_obtevents_name        = "evh-obuoc-obtevents"
eventhub_telemetry_name        = "evh-obuoc-telemetry"
consumer_group_names_obtevents = ["obuoc-eventproc", "obuoc"]
consumer_group_names_telemetry = ["obuoc-tsdb-telemetry", "obuoc", "adxobuoc"]
obuoc_vnet_name = "vnet-obuoc"
obuoc_vnet_address = "172.19.92.0/25"
azureservices_subnet_name = "snet-obuoc-common"
azureservices_subnet_address = "172.19.92.64/27"
linux_app_service_subnet_name = "snet-obuoc-linuxappservice"
linux_app_service_subnet_address = "172.19.92.96/27"
windows_app_service_subnet_name = "snet-obuoc-windowsappservice"
windows_app_service_subnet_address = "172.19.92.32/27"
agw_subnet_name = "snet-agw-obuoc"
appgw_subnet_address = "172.19.92.0/28"
obtsync_app_service_subnet_name = "snet-obuoc-obtsyncappservice"
obtsync_app_service_subnet_address = "172.19.92.16/28"
core_storageaccount_name           = "stuoccore"
cdn_storageaccount_name            = "stuoccdn"
tsdbtm_storageaccount_name         = "stuoctsdbtm"
core_sa_container_names                   = "azure-event-suppress-alarms"
azure_entity_postgresql_name = "pgsql-obuoc-entity"
postgresql_sku_name = "GP_Gen5_16"
postgresql_storage_mb = 102400
postgresql_backup_retention_days = 7
postgresql_geo_redundant_backup  = "false"
postgresql_server_version        = "11"
postgresql_ssl_enforcement       = "true"
postgresql_db_names = "uoc"
postgresql_db_charset            = "UTF8"
postgresql_db_collation          = "English_United States.1252"
azure_events_postgresql_name = "pgsql-obuoc-events"
azure_signalr_name = "signalr-obuoc"
postgresql_events_db_names = "events"
time_series_insights_telemetry_name = "tsdb-obuoc-telemetry"
event_source_Name = "es-tsdb-obuoc-telemetry"
law_name = "la-wsp-obuoc"
appinsights_name = "ai-obuoc"
user_audit_appinsights_name = "user-audit-ai-obuoc"
linux_app_service_plan_name         = "plan-obuoc-lin"
windows_app_service_plan_name       = "plan-obuoc-win"
obtsync_app_service_plan_name       = "plan-obuoc-obtsync"
obtsync_app_service_name                  = "app-obuoc-obtsync"
webui_app_service_name                    = "app-obuoc-webui"
graphql_entity_app_service_name           = "app-obuoc-graphql-entity"
graphql_event_app_service_name            = "app-obuoc-graphql-event"
timeseries_api_app_service_name           = "app-obuoc-timeseries"
utility_app_service_name                  = "app-obuoc-utility"
windows_function_app_name = "func-obuoc-eventprocessor" 
agw_public_ip_address_name = "pip-agw-obuoc"
public_ip_allocation_method = "Static"
public_ip_address_sku = "Standard"
agw_name = "agw-obuoc"
app_gateway_sku_name = "WAF_v2"
app_gateway_sku_tier = "WAF_v2"
app_gateway_sku_capacity = 10
route_obtsync = "/obtsync*"
route_graphqlevent = "/event*"
route_graphqlentity = "/entity*"
route_storage = "/blob*"
route_utility = "/utility*"
route_timeseriesapi = "/telemetry*"
route_eventhub_telemetry = "/evhns*"
route_eventprocessor = "/evtproc*"
storage_zone = ["privatelink.blob.core.windows.net", "privatelink.table.core.windows.net"]
app_zone = "privatelink.azurewebsites.net"
keyvault_zone = "privatelink.vaultcore.azure.net"
postgresql_zone = "privatelink.postgres.database.azure.com"
eventhub_zone = "privatelink.servicebus.windows.net"
function_subresource_names = "sites"
fn_storage_subresource_names = {"privatelink.blob.core.windows.net"  = "blob", "privatelink.table.core.windows.net" = "table"}
postgresql_subresource_names = "postgresqlServer"
key_vault_subresource_names = "vault"
event_hub_subresource_names = "namespace"
signalr_subresource_names = "signalr"
vm_size = "Standard_DS1_v2"
vm_storage_acc_type = "Premium_LRS"
vm_adminuser = "obuoc"
website_dns_server = "168.63.129.16"
obt_keycloak_client_id = "cs.user-token-provider"
obt_keycloak_login_host = "login.obs-test-unistad-we1.jcisaas.ai"
obt_keycloak_realm = "s2s"
obt_keycloak_username = "uoc-admin-service-account"
forge_auth_url = "https://developer.api.autodesk.com/authentication/v1/authenticate"
ob_graphql_id = "https://openblue-test.hostcountry.qa/v1/graphql"
ob_scope = "https://openblue-test.hostcountry.qa/v1/.default"
jwks_uri = "https://login.microsoftonline.com/937eee81-4a72-481a-a694-4315abbd5afd/discovery/v2.0/keys"
//az_ts_fqdn = "50fb3730-4e3b-4fde-beba-76c2cbbc0879.env.timeseries.azure.com"
msal_ts_scope = "https://api.timeseries.azure.com//.default"
ar_keycloak_url = "login.prod-us1.jcisaas.ai"
ar_tenant_url = "tenant-unistad"
ar_app_username = "Integration.app"
ar_client_id = "sop.sop-ui-service"
ar_sop_service_url = "https://fifa.prod-us1.activeresponder.ai/sop/graphql-integration"
ar_sop_service_new_url = "https://fifa.prod-us1.activeresponder.ai/sop/graphql"
obt_graphql_url = "https://openblue-test.hostcountry.qa/v1/graphql"
ob_consumer_group = "obuoc-eventproc"
ob_eventhub = "evh-obuoc-obtevents"
audiences = "https://obuoc-dev.hostcountry.qa/api"
downloadfolderpath = "C:\\\\BIMModels\\\\SVF_Files" 
gqlclienttimeout = "60000"
ping_utility_ercollectionid = "1caa43b4-85a4-438b-b351-a2e77133659b"
azurerm_kusto_cluster_name= "adxobuoc"
adx_sku_name_size = "Standard_D13_v2"
azurerm_kusto_database_name = "adx-db-obuoc-dev-unistad-001"
adx_subresource_names = "cluster"
eventhub_ns_name = "evhns-obuoc-1"
eventhub_name = "evh-obuoc-telemetry-1"
consumer_group_name = "obuoc-tsdb-telemetry-1"
eventhub_connection_name = "obuoc-tsdb-telemetry-1"
kusto_zone = "privatelink.westeurope.kusto.windows.net"
sxs_graphql_url = "https://obuoc-dev.hostcountry.qa/entity/graphql"
uoc_memeber_of_api_url = "https://graph.microsoft.com/v1.0/me/memberOf/"
windows_function_app_names = "func-obuoc-telemetryprocessor"
ob_consumer_groups = "adxobuoc-dev"
ob_eventhubs = "evh-obuoc-telemetry"
core_sa_event_archive_container_name = "uoc-event-archive"
