resource "azurerm_key_vault" "akv" {
  name                        = "${var.azure_keyvault_name}-${var.environment}-${var.suffix}"
  location                    = var.rg_obuoc_location
  resource_group_name         = var.rg_obuoc_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  purge_protection_enabled    = false
  soft_delete_retention_days  = 7

  sku_name = "standard"

  /*network_acls {
    bypass = "AzureServices"
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.azureservices_subnet_id, var.linux_app_service_subnet_id, var.windows_app_service_subnet_id, var.appgatway_subnet_id]
  }*/
  
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.aad_sp_object_id

    certificate_permissions = [
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "setissuers",
      "update",
    ]

    key_permissions = [
      "backup",
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey",
    ]

    secret_permissions = [
      "backup",
      "delete",
      "get",
      "list",
      "purge",
      "recover",
      "restore",
      "set",
    ]
  }

  lifecycle {
    ignore_changes = [
      access_policy
    ]
  }

  tags = var.tags
}

/*resource "azurerm_key_vault_secret" "example" {
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.akv.id
}*/

/*resource "azurerm_key_vault_access_policy" "uoc_key_vault_access_policy" {
  key_vault_id = azurerm_key_vault.akv.id
  tenant_id = var.tenant_id
  object_id = var.aad_sp_object_id

  //tenant_id = data.azurerm_client_config.current.tenant_id
  //object_id = data.azurerm_client_config.current.object_id

  certificate_permissions = [
    "create",
    "delete",
    "deleteissuers",
    "get",
    "getissuers",
    "import",
    "list",
    "listissuers",
    "managecontacts",
    "manageissuers",
    "setissuers",
    "update",
  ]

  key_permissions = [
    "backup",
    "create",
    "decrypt",
    "delete",
    "encrypt",
    "get",
    "import",
    "list",
    "purge",
    "recover",
    "restore",
    "sign",
    "unwrapKey",
    "update",
    "verify",
    "wrapKey",
  ]

  secret_permissions = [
    "backup",
    "delete",
    "get",
    "list",
    "purge",
    "recover",
    "restore",
    "set",
  ]
}

resource "azurerm_key_vault_key" "uoc_key_vault_key_diskencrypt" {
  name         = "${var.prefix}-${var.environment}-uoc-key-vault-key-diskencrypt"
  key_vault_id = azurerm_key_vault.akv.id
  key_type     = "RSA"
  key_size     = 4096

  depends_on = [azurerm_key_vault_access_policy.uoc_key_vault_access_policy]

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_disk_encryption_set" "uoc_disk_encryption_set" {
  name                = "${var.prefix}-${var.environment}-uoc-disk-encryption-set"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  key_vault_key_id    = azurerm_key_vault_key.uoc_key_vault_key_diskencrypt.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_key_vault_access_policy" "uoc_key_vault_access_policy_diskencrypt" {
  key_vault_id = azurerm_key_vault.akv.id

  tenant_id = azurerm_disk_encryption_set.uoc_disk_encryption_set.identity.0.tenant_id
  object_id = azurerm_disk_encryption_set.uoc_disk_encryption_set.identity.0.principal_id

  key_permissions = [
    "get",
    "decrypt",
    "encrypt",
    "sign",
    "purge",
    "delete",
    "unwrapKey",
    "verify",
    "wrapKey",
    "list"
  ]
}*/

resource "azurerm_key_vault_secret" "ar_app_password" {
  name         = "ar-app-password"
  value        = var.ar_app_password
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "evh_obuoc_obtevents_readonly" {
  name         = "evh-obuoc-obtevents-readonly"
  value        = var.evh_obuoc_obtevents_readonly
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "evh_obuoc_obtevents_write" {
  name         = "evh-obuoc-obtevents-write"
  value        = var.evh_obuoc_obtevents_write
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "evh_obuoc_telemetry_readonly" {
  name         = "evh-obuoc-telemetry-readonly"
  value        = var.evh_obuoc_telemetry_readonly
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "evh_obuoc_telemetry_write" {
  name         = "evh-obuoc-telemetry-write"
  value        = var.evh_obuoc_telemetry_write
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "open_blue_aad_client_secret" {
  name         = "open-blue-aad-client-secret"
  value        = var.open_blue_aad_client_secret
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "pgsql_obuoc_entity_gql_conn_string" {
  name         = "pgsql-obuoc-entity-gql-conn-string"
  value        = var.pgsql_obuoc_entity_gql_conn_string
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "pgsql_obuoc_entity_obtsync_conn_string" {
  name         = "pgsql-obuoc-entity-obtsync-conn-string"
  value        = var.pgsql_obuoc_entity_obtsync_conn_string
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "pgsql_obuoc_entity_evproc_conn_string" {
  name         = "pgsql-obuoc-entity-evproc-conn-string"
  value        = var.pgsql_obuoc_entity_evproc_conn_string
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "pgsql_obuoc_events_evproc_conn_string" {
  name         = "pgsql-obuoc-events-evproc-conn-string"
  value        = var.pgsql_obuoc_events_evproc_conn_string
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "pgsql_obuoc_events_gql_conn_string" {
  name         = "pgsql-obuoc-events-gql-conn-string"
  value        = var.pgsql_obuoc_events_gql_conn_string
  key_vault_id = azurerm_key_vault.akv.id
}


resource "azurerm_key_vault_secret" "st_uoc_func_conn_string" {
  name         = "st-uoc-func-conn-string"
  value        = var.st_uoc_func_conn_string
  key_vault_id = azurerm_key_vault.akv.id
}


resource "azurerm_key_vault_secret" "st_uoc_cdn_conn_string" {
  name         = "st-uoc-cdn-conn-string"
  value        = var.st_uoc_cdn_conn_string
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "uoc_aad_client_secret" {
  name         = "uoc-aad-client-secret"
  value        = var.uoc_aad_client_secret
  key_vault_id = azurerm_key_vault.akv.id
}


resource "azurerm_key_vault_secret" "uoc_forge_secret" {
  name         = "uoc-forge-secret"
  value        = var.uoc_forge_secret
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "pdb_admin_login_akv_key" {
  name         = "pdb-admin-login-akv-key"
  value        = var.pdb_admin_login_akv_key
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "pdb_admin_pwd_akv_key" {
  name         = "pdb-admin-pwd-akv-key"
  value        = var.pdb_admin_pwd_akv_key
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "obt_keycloak_password" {
  name         = "open-blue-keycloak-password"
  value        = var.obt_keycloak_password
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "forge_client_id" {
  name         = "ForgeClientId"
  value        = var.forge_client_id
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "forge_client_secret" {
  name         = "ForgeClientSecret"
  value        = var.forge_client_secret
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "autodesk_url" {
  name         = "AutoDeskURL"
  value        = var.autodesk_url
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "gql_tenantid" {
  name         = "GQLTenantId"
  value        = var.gql_tenantid
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "gql_clientid" {
  name         = "GQLClientId"
  value        = var.gql_clientid
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "gql_secret" {
  name         = "GQLSecret"
  value        = var.gql_secret
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "gql_scope" {
  name         = "GQLScope"
  value        = var.gql_scope
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "gql_url" {
  name         = "GQLURL"
  value        = var.gql_url
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "az_ad_tenantid" {
  name         = "AZADTennantID"
  value        = var.az_ad_tenantid
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "endpoint" {
  name         = "Endpoint"
  value        = var.endpoint
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "issuer" {
  name         = "Issuer"
  value        = var.issuer
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "valid_audiences" {
  name         = "ValidAudiences"
  value        = var.valid_audiences
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "downloadfolderpath" {
  name         = "DownloadFolderPath"
  value        = var.downloadfolderpath
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "gqlclienttimeout" {
  name         = "GQLClientTimeout"
  value        = var.gqlclienttimeout
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "ai_instrumentationkey" {
  name         = "InstrumentationKey"
  value        = var.ai_instrumentationkey
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "uoc_maptiler_map_conn_str" {
  name         = "uoc-maptiler-map-conn-str"
  value        = var.uoc_maptiler_map_conn_str
  key_vault_id = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "uoc_maptiler_tile_conn_str" {
  name         = "uoc-maptiler-tile-conn-str"
  value        = var.uoc_maptiler_tile_conn_str
  key_vault_id = azurerm_key_vault.akv.id
}

resource "null_resource" "keyvault2" {
  depends_on = [azurerm_key_vault_secret.obt_keycloak_password, azurerm_key_vault_secret.ar_app_password, azurerm_key_vault_secret.evh_obuoc_obtevents_readonly, azurerm_key_vault_secret.evh_obuoc_obtevents_write, azurerm_key_vault_secret.evh_obuoc_telemetry_readonly, azurerm_key_vault_secret.evh_obuoc_telemetry_write, azurerm_key_vault_secret.open_blue_aad_client_secret, azurerm_key_vault_secret.pgsql_obuoc_entity_gql_conn_string, azurerm_key_vault_secret.pgsql_obuoc_entity_obtsync_conn_string, azurerm_key_vault_secret.pgsql_obuoc_entity_evproc_conn_string, azurerm_key_vault_secret.pgsql_obuoc_events_evproc_conn_string, azurerm_key_vault_secret.pgsql_obuoc_events_gql_conn_string, azurerm_key_vault_secret.st_uoc_func_conn_string, azurerm_key_vault_secret.st_uoc_cdn_conn_string, azurerm_key_vault_secret.uoc_aad_client_secret, azurerm_key_vault_secret.uoc_forge_secret, azurerm_key_vault_secret.pdb_admin_login_akv_key, azurerm_key_vault_secret.pdb_admin_pwd_akv_key, azurerm_key_vault_secret.forge_client_id, azurerm_key_vault_secret.forge_client_secret, azurerm_key_vault_secret.autodesk_url, azurerm_key_vault_secret.gql_tenantid, azurerm_key_vault_secret.gql_clientid, azurerm_key_vault_secret.gql_secret, azurerm_key_vault_secret.gql_scope, azurerm_key_vault_secret.gql_url, azurerm_key_vault_secret.az_ad_tenantid, azurerm_key_vault_secret.endpoint, azurerm_key_vault_secret.issuer, azurerm_key_vault_secret.valid_audiences]
  provisioner "local-exec" {
    command = "sleep 5m"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update --resource-group ${var.rg_obuoc_name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --name ${var.azureservices_subnet_name}-${var.environment}-${var.suffix} --service-endpoints Microsoft.KeyVault"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update --resource-group ${var.rg_obuoc_name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --name ${var.agw_subnet_name}-${var.environment}-${var.suffix} --service-endpoints Microsoft.KeyVault"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update --resource-group ${var.rg_obuoc_name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --name ${var.windows_app_service_subnet_name}-${var.environment}-${var.suffix} --service-endpoints Microsoft.KeyVault"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update --resource-group ${var.rg_obuoc_name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --name ${var.obtsync_app_service_subnet_name}-${var.environment}-${var.suffix} --service-endpoints Microsoft.KeyVault"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update --resource-group ${var.rg_obuoc_name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --name ${var.linux_app_service_subnet_name}-${var.environment}-${var.suffix} --service-endpoints Microsoft.KeyVault"
  }
  provisioner "local-exec" {
    command = "az keyvault network-rule add --name ${azurerm_key_vault.akv.name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --subnet ${var.azureservices_subnet_name}-${var.environment}-${var.suffix}"
  }
  provisioner "local-exec" {
    command = "az keyvault network-rule add --name ${azurerm_key_vault.akv.name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --subnet ${var.agw_subnet_name}-${var.environment}-${var.suffix}"
  }
  provisioner "local-exec" {
    command = "az keyvault network-rule add --name ${azurerm_key_vault.akv.name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --subnet ${var.windows_app_service_subnet_name}-${var.environment}-${var.suffix}"
  }
  provisioner "local-exec" {
    command = "az keyvault network-rule add --name ${azurerm_key_vault.akv.name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --subnet ${var.obtsync_app_service_subnet_name}-${var.environment}-${var.suffix}"
  }
  provisioner "local-exec" {
    command = "az keyvault network-rule add --name ${azurerm_key_vault.akv.name} --vnet-name ${var.obuoc_vnet_name}-${var.environment}-${var.suffix} --subnet ${var.linux_app_service_subnet_name}-${var.environment}-${var.suffix}"
  }
  provisioner "local-exec" {
    command = "az keyvault update --resource-group ${var.rg_obuoc_name} --name ${azurerm_key_vault.akv.name} --bypass AzureServices"
  }
}