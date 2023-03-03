variable "azure_keyvault_name" { }
variable "tenant_id" { }
variable "aad_sp_object_id" { }
variable "tags" { }
variable "suffix" { }
variable "environment" { }
variable "rg_obuoc_name" { }
variable "rg_obuoc_location" { }
variable "ar_app_password" { }
variable "evh_obuoc_obtevents_readonly" { }
variable "evh_obuoc_obtevents_write" { }
variable "evh_obuoc_telemetry_readonly" { }
variable "evh_obuoc_telemetry_write" { }
variable "open_blue_aad_client_secret" { }
variable "pgsql_obuoc_entity_gql_conn_string" { }
variable "pgsql_obuoc_entity_obtsync_conn_string" { }
variable "pgsql_obuoc_entity_evproc_conn_string" { }
variable "pgsql_obuoc_events_evproc_conn_string" { }
variable "pgsql_obuoc_events_gql_conn_string" { }
variable "st_uoc_func_conn_string" { }
variable "st_uoc_cdn_conn_string" { }
variable "uoc_aad_client_secret" { }
variable "uoc_forge_secret" { }
variable "pdb_admin_login_akv_key" { }
variable "pdb_admin_pwd_akv_key" { }
/*variable "azureservices_subnet_id" { }
variable "linux_app_service_subnet_id" { }
variable "windows_app_service_subnet_id" { }
variable "appgatway_subnet_id" { }*/
variable "subscription_id" { }
variable "obuoc_vnet_name" { }
variable "azureservices_subnet_name" { }
variable "agw_subnet_name" { }
variable "windows_app_service_subnet_name" { }
variable "obtsync_app_service_subnet_name" { }
variable "linux_app_service_subnet_name" { }
variable "obt_keycloak_password" { }
variable "forge_client_id" { }
variable "forge_client_secret" { }
variable "autodesk_url" { }
variable "gql_tenantid" { }
variable "gql_clientid" { }
variable "gql_secret" { }
variable "gql_scope" { }
variable "gql_url" { }
variable "az_ad_tenantid" { }
variable "endpoint" { }
variable "issuer" { }
variable "valid_audiences" { }
variable "downloadfolderpath" { }
variable "gqlclienttimeout" { }
variable "ai_instrumentationkey" { }
variable "uoc_maptiler_map_conn_str" { }
variable "uoc_maptiler_tile_conn_str" { }
