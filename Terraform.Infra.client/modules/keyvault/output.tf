output "keyvault" {
  value = azurerm_key_vault.akv
}

output "obt_keycloak_password" {
  value = azurerm_key_vault_secret.obt_keycloak_password.version
}

output "pg_connection_string" {
  value = azurerm_key_vault_secret.pgsql_obuoc_entity_obtsync_conn_string.version
}

output "ob_secret" {
  value = azurerm_key_vault_secret.open_blue_aad_client_secret.version
}

output "entity_db_url" {
  value = azurerm_key_vault_secret.pgsql_obuoc_entity_gql_conn_string.version
}

output "event_db_url" {
  value = azurerm_key_vault_secret.pgsql_obuoc_events_gql_conn_string.version
}

output "msal_client_secret" {
  value = azurerm_key_vault_secret.uoc_aad_client_secret.version
}

output "uoc_core_sa_conn_string" {
  value = azurerm_key_vault_secret.st_uoc_func_conn_string.version
}

output "forge_secret" {
  value = azurerm_key_vault_secret.uoc_forge_secret.version
}

output "ar_app_password" {
  value = azurerm_key_vault_secret.ar_app_password.version
}

output "evh_obuoc_obtevents_readonly" {
  value = azurerm_key_vault_secret.evh_obuoc_obtevents_readonly.version
}

output "evh_obuoc_telemetry_write" {
  value = azurerm_key_vault_secret.evh_obuoc_telemetry_write.version
}

output "pgsql_obuoc_entity_evproc_conn_string" {
  value = azurerm_key_vault_secret.pgsql_obuoc_entity_evproc_conn_string.version
}

output "pgsql_obuoc_events_evproc_conn_string" {
  value = azurerm_key_vault_secret.pgsql_obuoc_events_evproc_conn_string.version
}

output "forge_client_id" {
  value = azurerm_key_vault_secret.forge_client_id.version
}

output "forge_client_secret" {
  value = azurerm_key_vault_secret.forge_client_secret.version
}

output "autodesk_url" {
  value = azurerm_key_vault_secret.autodesk_url.version
}

output "gql_tenantid" {
  value = azurerm_key_vault_secret.gql_tenantid.version
}

output "gql_clientid" {
  value = azurerm_key_vault_secret.gql_clientid.version
}

output "gql_secret" {
  value = azurerm_key_vault_secret.gql_secret.version
}

output "gql_scope" {
  value = azurerm_key_vault_secret.gql_scope.version
}

output "gql_url" {
  value = azurerm_key_vault_secret.gql_url.version
}

output "az_ad_tenantid" {
  value = azurerm_key_vault_secret.az_ad_tenantid.version
}

output "endpoint" {
  value = azurerm_key_vault_secret.endpoint.version
}

output "issuer" {
  value = azurerm_key_vault_secret.issuer.version
}

output "valid_audiences" {
  value = azurerm_key_vault_secret.valid_audiences.version
}

output "uoc_maptiler_map_conn_str" {
 value =  azurerm_key_vault_secret.uoc_maptiler_map_conn_str.version
}

output "uoc_maptiler_tile_conn_str" {
 value =  azurerm_key_vault_secret.uoc_maptiler_tile_conn_str.version
}


//-var="forge_client_version=${{ parameters.forge_client_version }}" -var="forge_client_secret=${{ parameters.forge_client_secret }}" -var="autodesk_url=${{ parameters.autodesk_url }}" -var="gql_tenantversion=${{ parameters.gql_tenantversion }}" -var="gql_clientversion=${{ parameters.gql_clientversion }}" -var="gql_secret=${{ parameters.gql_secret }}" -var="gql_scope=${{ parameters.gql_scope }}" -var="gql_url=${{ parameters.gql_url }}" -var="az_ad_tenantversion=${{ parameters.az_ad_tenantversion }}" -var="endpoint=${{ parameters.endpoint }}" -var="issuer=${{ parameters.issuer }}" -var="valversion_audiences=${{ parameters.valversion_audiences }}" 

//azurerm_key_vault_secret.obt_keycloak_password, azurerm_key_vault_secret.ar_app_password, azurerm_key_vault_secret.evh_obuoc_obtevents_readonly, azurerm_key_vault_secret.evh_obuoc_obtevents_write, azurerm_key_vault_secret.evh_obuoc_telemetry_readonly, azurerm_key_vault_secret.evh_obuoc_telemetry_write, azurerm_key_vault_secret.open_blue_aad_client_secret, azurerm_key_vault_secret.pgsql_obuoc_entity_gql_conn_string, azurerm_key_vault_secret.pgsql_obuoc_entity_obtsync_conn_string, azurerm_key_vault_secret.pgsql_obuoc_entity_evproc_conn_string, azurerm_key_vault_secret.pgsql_obuoc_events_evproc_conn_string, azurerm_key_vault_secret.pgsql_obuoc_events_gql_conn_string, azurerm_key_vault_secret.st_uoc_func_conn_string, azurerm_key_vault_secret.st_uoc_cdn_conn_string, azurerm_key_vault_secret.uoc_aad_client_secret, azurerm_key_vault_secret.uoc_forge_secret, azurerm_key_vault_secret.pdb_admin_login_akv_key, azurerm_key_vault_secret.pdb_admin_pwd_akv_key

// forge_client_version, forge_client_secret, autodesk_url, gql_tenantversion, gql_clientversion, gql_secret, gql_scope, gql_url, az_ad_tenantversion, endpoint, issuer, valversion_audiences

output "evh_obuoc_telemetry_readonly" {
 value = azurerm_key_vault_secret.evh_obuoc_telemetry_readonly.version
}