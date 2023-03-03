resource "azurerm_app_service_plan" "linux_app_service_plan" {
  name                = "${var.linux_app_service_plan_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  kind                = "Linux"
  reserved            = true
  
  sku {
    tier = "PremiumV2"
    size = "P3v3"
  }
  tags                 = var.tags
}

resource "azurerm_monitor_autoscale_setting" "linux_app_service_plan_autoscale" {
  name                = "Autoscalelin--${var.environment}-${var.suffix}"
  resource_group_name = var.rg_obuoc_name
  location            = var.rg_obuoc_location
  target_resource_id  = azurerm_app_service_plan.linux_app_service_plan.id
  depends_on = [azurerm_app_service_plan.linux_app_service_plan]

  profile {
    name = "default"
    capacity {
      default = 1
      minimum = 1
      maximum = 10
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.linux_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 60
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    } 
    rule {
      metric_trigger {
        metric_name        = "MemoryPercentage"
        metric_resource_id = azurerm_app_service_plan.linux_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 60
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.linux_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "MemoryPercentage"
        metric_resource_id = azurerm_app_service_plan.linux_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }  
}

resource "azurerm_app_service_plan" "windows_app_service_plan" {
  name                = "${var.windows_app_service_plan_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  kind                = "Windows"

  sku {
    tier = "PremiumV2"
    size = "P3v3"
  }
  tags                = var.tags
}

resource "azurerm_monitor_autoscale_setting" "windows_app_service_plan_autoscale" {
  name                = "AutoscaleWin-${var.environment}-${var.suffix}"
  resource_group_name = var.rg_obuoc_name
  location            = var.rg_obuoc_location
  target_resource_id  = azurerm_app_service_plan.windows_app_service_plan.id
  depends_on = [azurerm_app_service_plan.windows_app_service_plan]

  profile {
    name = "default"
    capacity {
      default = 1
      minimum = 1
      maximum = 10
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.windows_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 60
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "MemoryPercentage"
        metric_resource_id = azurerm_app_service_plan.windows_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 60
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.windows_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "MemoryPercentage"
        metric_resource_id = azurerm_app_service_plan.windows_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}

resource "azurerm_app_service_plan" "obtsync_app_service_plan" {
  name                = "${var.obtsync_app_service_plan_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  kind                = "Windows"

  sku {
    tier = "PremiumV2"
    size = "P3v2"
  }
  tags                = var.tags
}

/*resource "azurerm_monitor_autoscale_setting" "obtsync_app_service_plan_autoscale" {
  name                = "AutoscaleObtSync-${var.environment}-${var.suffix}"
  resource_group_name = var.rg_obuoc_name
  location            = var.rg_obuoc_location
  target_resource_id  = azurerm_app_service_plan.obtsync_app_service_plan.id
  depends_on = [azurerm_app_service_plan.obtsync_app_service_plan]

  profile {
    name = "default"
    capacity {
      default = 1
      minimum = 1
      maximum = 10
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.obtsync_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 60
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "MemoryPercentage"
        metric_resource_id = azurerm_app_service_plan.obtsync_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 60
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.obtsync_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "MemoryPercentage"
        metric_resource_id = azurerm_app_service_plan.obtsync_app_service_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}*/

resource "azurerm_app_service" "obtsync_app_service" {
  depends_on = [azurerm_app_service_plan.obtsync_app_service_plan]
  name                = "${var.obtsync_app_service_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  app_service_plan_id = azurerm_app_service_plan.obtsync_app_service_plan.id
  https_only          = true


  site_config {
    dotnet_framework_version = "v4.0"
    windows_fx_version = "aspnet|V4.8"
    min_tls_version           = "1.2"
    ftps_state = "Disabled"
    always_on                = true
    use_32_bit_worker_process = false
    cors {
        allowed_origins      = ["*"]
    }
    health_check_path = "/status"
  }

 /* auth_settings {
    enabled = true 
    active_directory {
      client_id = var.client_id
      client_secret = var.client_secret
      allowed_audiences = [var.audience]
    }
    issuer = var.issuer_uri
    default_provider = "MicrosoftAccount"
    token_store_enabled = true
  }*/

  identity{
    type                     = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.ai_instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "DiagnosticServices_EXTENSION_VERSION" = "~3"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.ai_connection_string
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET" = "UFRuYpAf0_4BTQ64s~WT4H9TrmjmXW8_Q_"
    "WEBSITE_VNET_ROUTE_ALL" = "1"
    "ErcollectionIds" = var.ercollection_id
    "OBClientId" = var.ob_client_id
    "OBGraphQLURL" = var.ob_graphql_id
    "OBScope" = var.ob_scope
    "OBSecret" = "@Microsoft.KeyVault(SecretUri=${var.ob_secret})"
    "OBTenantId" = var.ob_tenant_id
    "PGConnectString" = "@Microsoft.KeyVault(SecretUri=${var.pg_connection_string})"
    "subscriptionId" = var.subscription_id
    "WEBSITE_DNS_SERVER" = var.website_dns_server
    "WEBSITE_HEALTHCHECK_MAXPINGFAILURES" = "2"
    "KeepTransactionNumber" = "70000"
    "OBTKeycloakAuth" = "true"
    "OBTKeycloakClientId" = var.obt_keycloak_client_id
    "OBTKeycloakLoginHost" = var.obt_keycloak_login_host
    "OBTKeycloakPassword" = "@Microsoft.KeyVault(SecretUri=${var.obt_keycloak_password})"
    "OBTKeycloakRealm" = var.obt_keycloak_realm
    "OBTKeycloakUsername" = var.obt_keycloak_username
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "Logging:ApplicationInsights:LogLevel:Default" = "Information"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "~1"
    "XDT_MicrosoftApplicationInsights_Java" = "1"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"
    "XDT_MicrosoftApplicationInsights_NodeJS" = "disabled"
    "XDT_MicrosoftApplicationInsights_PreemptSdk" = "disabled"
    "PGEventConnectString" = "@Microsoft.KeyVault(SecretUri=${var.pgsql_obuoc_events_evproc_conn_string})"
    "EnableAlarmEventCount" = "true"
    "AlarmEventCountInterval" = "40"
    "EnableEventCleanup" = "true"
    "EventRetentionInDays" = "60"
    "ArchiveStorageConnectString" = "@Microsoft.KeyVault(SecretUri=${var.uoc_core_sa_conn_string})"
    "ArchiveContainerName" = var.core_sa_event_archive_container_name
    "dbTransactionLimit" = "5000"
    "EnableChangefeed" = "true"
    "EnableAlarmAging" = "true"
    "MissingAlarmIntervalInHrs"= "1"
  }
  tags                = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "obtsync_app_service_virtual_network_swift_connection" {
  depends_on = [azurerm_app_service.obtsync_app_service]
  app_service_id      = azurerm_app_service.obtsync_app_service.id
  subnet_id           = var.obtsync_app_service_subnet_id
}

resource "azurerm_key_vault_access_policy" "obtsync_kv_accesspolicy" {
  depends_on = [azurerm_app_service.obtsync_app_service]
  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_app_service.obtsync_app_service.identity[0].tenant_id
  object_id    = azurerm_app_service.obtsync_app_service.identity[0].principal_id

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

resource "azurerm_app_service" "webui_app_service" {
  depends_on = [azurerm_app_service_plan.windows_app_service_plan]
  name                = "${var.webui_app_service_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  app_service_plan_id = azurerm_app_service_plan.windows_app_service_plan.id
  https_only          = true

  site_config {
    dotnet_framework_version = "v4.0"
    windows_fx_version = "aspnet|V4.8"
    min_tls_version           = "1.2"
    always_on                = true
    ftps_state = "Disabled"
    use_32_bit_worker_process = false
    cors {
        allowed_origins      = ["*"]
    }
    default_documents   = ["index.html"]
  }

  identity{
    type                     = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.ai_instrumentation_key
    //"APPLICATIONINSIGHTS_CONNECTION_STRING" = var.ai_connection_string
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    "DiagnosticServices_EXTENSION_VERSION" = "~3"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "WEBSITE_VNET_ROUTE_ALL" = "1"
    "WEBSITE_DNS_SERVER" = var.website_dns_server
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "~1"
    "XDT_MicrosoftApplicationInsights_Java" = "1"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"
    "XDT_MicrosoftApplicationInsights_NodeJS" = "disabled"
    "XDT_MicrosoftApplicationInsights_PreemptSdk" = "disabled"
    "APP_LOG_UTILITY_URL" = var.app_log_utility_url
  }

  tags                = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "webui_app_service_virtual_network_swift_connection" {
  depends_on = [azurerm_app_service.webui_app_service]
  app_service_id      = azurerm_app_service.webui_app_service.id
  subnet_id           = var.windows_app_service_subnet_id
}

resource "azurerm_key_vault_access_policy" "webui_kv_accesspolicy" {
  depends_on = [azurerm_app_service.webui_app_service]
  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_app_service.webui_app_service.identity[0].tenant_id
  object_id    = azurerm_app_service.webui_app_service.identity[0].principal_id

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

resource "azurerm_app_service" "graphql_entity_app_service" {
  depends_on = [azurerm_app_service_plan.linux_app_service_plan]
  name                = "${var.graphql_entity_app_service_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  app_service_plan_id = azurerm_app_service_plan.linux_app_service_plan.id
  https_only          = true

  site_config {
    linux_fx_version = "NODE|14-lts"
    min_tls_version           = "1.2"
    ftps_state = "Disabled"
    always_on                = true
    use_32_bit_worker_process = false
    cors {
        allowed_origins      = [var.cors_url]
    }
    health_check_path = "/status"
  }

  identity{
    type                     = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.ai_instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.ai_connection_string
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
    "DiagnosticServices_EXTENSION_VERSION" = "~3"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "WEBSITE_HEALTHCHECK_MAXPINGFAILURES" = "2"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk" = "disabled"
    "WEBSITE_VNET_ROUTE_ALL" = "1"
    "AUDIENCE" = var.audience
    "DATABASE_SCHEMA" = "public"
    "DATABASE_URL" = "@Microsoft.KeyVault(SecretUri=${var.entity_db_url})"
    "DISABLE_AUTH" = "false"
    "ISSUER_URI" = "@Microsoft.KeyVault(SecretUri=${var.issuer})"
    "JWKS_URI" = var.jwks_uri
    "PGSSLMODE" = "require"
    "PORT" = "5001"
    "IS_PRODUCTION" = "true"
    "WEBSITE_DNS_SERVER" = var.website_dns_server
    "Logging.ApplicationInsights.LogLevel.Default" = "Information"
    "UOC_MEMBER_OF_API_URL" = var.uoc_memeber_of_api_url
    /*"Dev_CORS_URL" = var.dev_cors_url
    "Test_CORS_URL" = var.test_cors_url
    "Stage_CORS_URL" = var.stage_cors_url
    "Prod_CORS_URL" = var.prod_cors_url*/
  }

  tags                = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "graphql_entity_app_service_virtual_network_swift_connection" {
  depends_on = [azurerm_app_service.graphql_entity_app_service]
  app_service_id      = azurerm_app_service.graphql_entity_app_service.id
  subnet_id           = var.linux_app_service_subnet_id
}

resource "azurerm_key_vault_access_policy" "graphql_entity_kv_accesspolicy" {
  depends_on = [azurerm_app_service.graphql_entity_app_service]
  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_app_service.graphql_entity_app_service.identity[0].tenant_id
  object_id    = azurerm_app_service.graphql_entity_app_service.identity[0].principal_id

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

resource "azurerm_app_service" "graphql_event_app_service" {
  depends_on = [azurerm_app_service_plan.linux_app_service_plan]
  name                = "${var.graphql_event_app_service_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  app_service_plan_id = azurerm_app_service_plan.linux_app_service_plan.id
  https_only          = true

  site_config {
    linux_fx_version = "NODE|14-lts"
    min_tls_version           = "1.2"
    ftps_state = "Disabled"
    always_on                = true
    use_32_bit_worker_process = false
    cors {
        allowed_origins      = [var.cors_url]
    }
    health_check_path = "/status"
  }

  identity{
    type                     = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.ai_instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.ai_connection_string
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
    "DiagnosticServices_EXTENSION_VERSION" = "~3"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "WEBSITE_HEALTHCHECK_MAXPINGFAILURES" = "2"
    "WEBSITE_VNET_ROUTE_ALL" = "1"
    "AUDIENCE" = var.audience
    "DATABASE_SCHEMA" = "uoc"
    "DATABASE_URL" = "@Microsoft.KeyVault(SecretUri=${var.event_db_url})"
    "DISABLE_AUTH" = "false"
    "ISSUER_URI" = "@Microsoft.KeyVault(SecretUri=${var.issuer})"
    "JWKS_URI" = var.jwks_uri
    "PGSSLMODE" = "require"
    "PORT" = "5000"
    "IS_PRODUCTION" = "true"
    "WEBSITE_DNS_SERVER" = var.website_dns_server
    "Logging.ApplicationInsights.LogLevel.Default" = "Information"
    "UOC_MEMBER_OF_API_URL" = var.uoc_memeber_of_api_url
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk" = "disabled"
    /*"Dev_CORS_URL" = var.dev_cors_url
    "Test_CORS_URL" = var.test_cors_url
    "Stage_CORS_URL" = var.stage_cors_url
    "Prod_CORS_URL" = var.prod_cors_url*/
  }

  tags                = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "graphql_event_app_service_virtual_network_swift_connection" {
  depends_on = [azurerm_app_service.graphql_event_app_service]
  app_service_id      = azurerm_app_service.graphql_event_app_service.id
  subnet_id           = var.linux_app_service_subnet_id
}

resource "azurerm_key_vault_access_policy" "graphql_event_kv_accesspolicy" {
  depends_on = [azurerm_app_service.graphql_event_app_service]
  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_app_service.graphql_event_app_service.identity[0].tenant_id
  object_id    = azurerm_app_service.graphql_event_app_service.identity[0].principal_id

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

resource "azurerm_app_service" "timeseries_api_app_service" {
  depends_on = [azurerm_app_service_plan.linux_app_service_plan]
  name                = "${var.timeseries_api_app_service_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  app_service_plan_id = azurerm_app_service_plan.linux_app_service_plan.id
  https_only          = true

  site_config {
    linux_fx_version = "NODE|14-lts"
    ftps_state = "Disabled"
    min_tls_version           = "1.2"
    always_on                = true
    use_32_bit_worker_process = false
    cors {
        allowed_origins      = ["*"]
    }
  }

/*  auth_settings {
    enabled = true 
    active_directory {
      client_id = var.client_id
      client_secret = var.client_secret
      allowed_audiences = [var.audience]
    }
    issuer = var.issuer_uri
    default_provider = "MicrosoftAccount"
    token_store_enabled = true
  }*/

  identity{
    type                     = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.ai_instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.ai_connection_string
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
    "WEBSITE_VNET_ROUTE_ALL" = "1"
    "AZ_TS_FQDN" = var.az_ts_fqdn
    "AZ_TS_API_VERSION" = "2020-07-31"
    "AZ_TS_STORE_TYPE" = "WarmStore"
    "MSAL_TENNANT_ID" = var.msal_tenant_id
    "MSAL_CLIENT_ID" = var.msal_client_id
    "MSAL_CLIENT_SECRET" = "@Microsoft.KeyVault(SecretUri=${var.msal_client_secret})"
    "MSAL_TS_SCOPE" = var.msal_ts_scope
    "WEBSITE_DNS_SERVER" = var.website_dns_server
    "ADX_TABLE" = "telemetry"
    "ADX_DATABASE" =  "${var.azurerm_kusto_database_name}"
    "ADX_APP_KEY" = "@Microsoft.KeyVault(SecretUri=${var.msal_client_secret})"
    "ADX_APP_ID"  = var.adx_app_id
    "ADX_CONNECTION_STRING" = var.adx_connection_string
    "SXS_GRAPHQL_URL" = var.sxs_graphql_url
    "UOC_MEMBER_OF_API_URL" = var.uoc_memeber_of_api_url
    "DiagnosticServices_EXTENSION_VERSION" = "3"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET" = "UFRuYpAf0_4BTQ64s~WT4H9TrmjmXW8_Q_"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk" = "disabled"    
  }

  tags                = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "timeseries_api_app_service_virtual_network_swift_connection" {
  depends_on = [azurerm_app_service.timeseries_api_app_service]
  app_service_id      = azurerm_app_service.timeseries_api_app_service.id
  subnet_id           = var.linux_app_service_subnet_id
}

resource "azurerm_key_vault_access_policy" "timeseries_api_kv_accesspolicy" {
  depends_on = [azurerm_app_service.timeseries_api_app_service]
  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_app_service.timeseries_api_app_service.identity[0].tenant_id
  object_id    = azurerm_app_service.timeseries_api_app_service.identity[0].principal_id

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

resource "azurerm_app_service" "utility_app_service" {
  depends_on = [azurerm_app_service_plan.linux_app_service_plan]
  name                = "${var.utility_app_service_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  app_service_plan_id = azurerm_app_service_plan.linux_app_service_plan.id
  https_only          = true

  site_config {
    linux_fx_version = "NODE|14-lts"
    ftps_state = "Disabled"
    min_tls_version           = "1.2"
    always_on                = true
    use_32_bit_worker_process = false
    cors {
        allowed_origins      = ["*"]
    }
  }

/*  auth_settings {
    enabled = true 
    active_directory {
      client_id = var.client_id
      client_secret = var.client_secret
      allowed_audiences = [var.audience]
    }
    issuer = var.issuer_uri
    default_provider = "MicrosoftAccount"
    token_store_enabled = true
  }*/

  identity{
    type                     = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.ai_instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.ai_connection_string
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
    "WEBSITE_VNET_ROUTE_ALL" = "1"
    "IS_PRODUCTION" = "true"
    "PORT" = "8080"
    "AR_KEYCLOAK_URL" = var.ar_keycloak_url
    "FORGE_CLIENT_ID" = var.forge_client_id
    "FORGE_SECRET" = "@Microsoft.KeyVault(SecretUri=${var.forge_secret})"
    "AR_TENANT_URL" = var.ar_tenant_url
    "AR_APP_USERNAME" = var.ar_app_username
    "AR_APP_PASSWORD" = "@Microsoft.KeyVault(SecretUri=${var.ar_app_password})"
    "AR_CLIENT_ID" = var.ar_client_id
    "AR_SOP_SERVICE_URL" = var.ar_sop_service_url
    "AR_SOP_SERVICE_NEW_URL" = var.ar_sop_service_new_url
    "OBT_MSAL_CLIENT_SECRET" = "@Microsoft.KeyVault(SecretUri=${var.ob_secret})"
    "OBT_MSAL_CLIENT_ID" = var.msal_client_id
    "MSAL_TENANT_ID" = var.msal_tenant_id
    "MSAL_TS_SCOPE" = var.msal_ts_scope
    "OBT_GRAPHQL_URL" = var.obt_graphql_url
    "OBT_ER_COLLECTION_ID" = var.ercollection_id
    "OBT_SUBSCRIPTION_ID" = var.obt_subscription_id
    "WEBSITE_DNS_SERVER" = var.website_dns_server
    "OBT_KEYCLOAK_AUTH" = "true"
    "OBT_KEYCLOAK_CLIENT_ID" = var.obt_keycloak_client_id
    "OBT_KEYCLOAK_LOGIN_HOST" = var.obt_keycloak_login_host
    "OBT_KEYCLOAK_PASSWORD" = "@Microsoft.KeyVault(SecretUri=${var.obt_keycloak_password})"
    "OBT_KEYCLOAK_REALM" = var.obt_keycloak_realm
    "OBT_KEYCLOAK_USERNAME" = var.obt_keycloak_username
    "FORGE_AUTH_URL" = var.forge_auth_url
    "PING_ONLY_ER_COLLECTION_ID" = var.ping_utility_ercollectionid
    "MAPTILER_TILE_CONNECTION_STRING" = "@Microsoft.KeyVault(SecretUri=${var.uoc_maptiler_tile_conn_str})"
    "MAPTILER_MAP_CONNECTION_STRING"  = "@Microsoft.KeyVault(SecretUri=${var.uoc_maptiler_map_conn_str})"
    "DiagnosticServices_EXTENSION_VERSION" = "3"
    "InstrumentationEngine_EXTENSION_VERSION" = "disabled"
    "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET" = "UFRuYpAf0_4BTQ64s~WT4H9TrmjmXW8_Q_"
    "SnapshotDebugger_EXTENSION_VERSION" = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode" = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk" = "disabled"
    "ENABLE_OCCUPANCY"  = "true"
    "OCCUPANCY_API_EVENTS_URL" = var.BOTNOTCH_ENDPOINT_FOR_EVENTS
    "OCCUPANCY_API_TURNSTILE_COUNT_URL" = var.BOTNOTCH_ENDPOINT_FOR_TURNSTILE_DETAILS
    "OCCUPANCY_API_BEARER_TOKEN" = var.BOTNOTCH_API_BEARER_TOKEN
    "OCCUPANCY_API_TIMESTAMP_OFFSET" = "+03:00"
    "OCCUPANCY_API_EVENT_END_BUFFER_IN_HOURS" = "1"
    "OCCUPANCY_API_EVENT_CHECK_INTERVAL_IN_SECONDS" = "120"
    "UOC_EVENT_GRAPHQL_URL" = var.obt_event_graphql_url
    "UOC_EVENT_GQL_URL" = var.obt_event_gql_url
    "UOC_MSAL_TENNANT_ID" = var.uoc_msal_tenant_id
    "UOC_MSAL_CLIENT_ID" = var.uoc_msal_client_id
    "UOC_MSAL_CLIENT_SECRET" = var.uoc_msal_client_secret
    "UOC_MSAL_SCOPE" = var.uoc_msal_scope

  }

  tags                = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "utility_app_service_virtual_network_swift_connection" {
  depends_on = [azurerm_app_service.utility_app_service]
  app_service_id      = azurerm_app_service.utility_app_service.id
  subnet_id           = var.linux_app_service_subnet_id
}

resource "azurerm_key_vault_access_policy" "utility_kv_accesspolicy" {
  depends_on = [azurerm_app_service.utility_app_service]
  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_app_service.utility_app_service.identity[0].tenant_id
  object_id    = azurerm_app_service.utility_app_service.identity[0].principal_id

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

resource "azurerm_function_app" "windows_function_app" {
  depends_on = [azurerm_app_service_plan.windows_app_service_plan]
  name                       = "${var.windows_function_app_name}-${var.environment}-${var.suffix}"
  location                   = var.rg_obuoc_location
  resource_group_name        = var.rg_obuoc_name
  app_service_plan_id        = azurerm_app_service_plan.windows_app_service_plan.id
  storage_account_name       = var.core_storageaccount_name
  storage_account_access_key = var.core_storage_account_primary_access_key
  version                    = "~4"
  https_only                 = true

  site_config {
    dotnet_framework_version = "v6.0"
    always_on                = true
    min_tls_version           = "1.2"
    ftps_state = "Disabled"
    use_32_bit_worker_process = false
    cors {
        allowed_origins      = ["*"]
    }
  }
  
  identity{
    type                     = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.ai_instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.ai_connection_string
    "AzureWebJobsDashboard" = "DefaultEndpointsProtocol=https;AccountName=stuoccoretestustdwe1;AccountKey=+7nm74io7sLEAWYvvi5X3HD8zAyGvC+4zrNiHznwtNagTj9bMT8R5hJ7Y+Bvm01ascOy12t0ymWOyoM/0eefeQ==;EndpointSuffix=core.windows.net"
    "AzureWebJobsStorage" = "DefaultEndpointsProtocol=https;AccountName=stuoccoretestustdwe1;AccountKey=+7nm74io7sLEAWYvvi5X3HD8zAyGvC+4zrNiHznwtNagTj9bMT8R5hJ7Y+Bvm01ascOy12t0ymWOyoM/0eefeQ==;EndpointSuffix=core.windows.net"
    "FUNCTIONS_EXTENSION_VERSION" = "~4"
    "WEBSITE_VNET_ROUTE_ALL" = "1"  
    "OBTHubConnectionString" = "@Microsoft.KeyVault(SecretUri=${var.evh_obuoc_obtevents_readonly})"
    "OBConsumerGroupName" = var.ob_consumer_group
    "OBEventHubName" = "${var.ob_eventhub}-${var.environment}-${var.suffix}"
    "TelemetryEventhubConnString" = "@Microsoft.KeyVault(SecretUri=${var.evh_obuoc_telemetry_write})"
    "TelemetryEventhubName" = var.telemetryeventhubname
    "UNISTAD_ENTITIES_POSTGRES_CONNECTION_STRING" = "@Microsoft.KeyVault(SecretUri=${var.pgsql_obuoc_entity_evproc_conn_string})"
    "UNISTAD_EVENTS_POSTGRES_CONNECTION_STRING " = "@Microsoft.KeyVault(SecretUri=${var.pgsql_obuoc_events_evproc_conn_string})"
    "WEBSITE_DNS_SERVER" = var.website_dns_server
    "AzureFunctionsJobHost__logging__logLevel__Function" = "Debug"
    "OpenIdEndpoint" = "@Microsoft.KeyVault(SecretUri=${var.endpoint})"
    "ValidIssuer" = "@Microsoft.KeyVault(SecretUri=${var.issuer})"
    "ValidAudience" = var.valid_audiences
    "SignalRConnection" = var.signalr_connection_string
    "SignalRHubName" = "Events"
    "SAStorageAccountConnectionString" = "@Microsoft.KeyVault(SecretUri=${var.uoc_core_sa_conn_string})"
    "SAContainerName" = var.core_sa_container_names
    "SARuleFileName" = "Rules.Json"
    "SAInvalidateCacheInDays" = "30"
    "SACacheKeyName" = "RulesConfig"
    "ADX_TABLENAME" = "telemetry"
    "ADX_DBNAME" =  "${var.azurerm_kusto_database_name}"
    "ADX_APPKEY" = "@Microsoft.KeyVault(SecretUri=${var.msal_client_secret})"
    "ADX_APPID"  = var.adx_app_id
    "ADX_CLUSTERPATH" = var.adx_connection_string
    "ADX_APPTENANT" = var.tenant_id
    "ConnectorComponentIdsForWindSpeed" = "CC_ID_1,CC_ID_2"
    "ConnectorComponentIdsForPitch" = "CC_ID_1,CC_ID_2"
    "ConnectorComponentsInterval"   = "60000"
  }

  tags                       = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "windows_function_app_virtual_network_swift_connection" {
  depends_on = [azurerm_function_app.windows_function_app]
  app_service_id      = azurerm_function_app.windows_function_app.id
  subnet_id           = var.windows_app_service_subnet_id
}

resource "azurerm_key_vault_access_policy" "windows_kv_accesspolicy" {
  depends_on = [azurerm_function_app.windows_function_app]
  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_function_app.windows_function_app.identity[0].tenant_id
  object_id    = azurerm_function_app.windows_function_app.identity[0].principal_id

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

resource "azurerm_storage_account_network_rules" "core_network_rules_Deny" {
  depends_on = [azurerm_function_app.windows_function_app]
  resource_group_name        = var.rg_obuoc_name
  storage_account_name = var.core_storageaccount_name

  default_action             = "Deny"
  virtual_network_subnet_ids = [var.azureservices_subnet_id, var.linux_app_service_subnet_id, var.windows_app_service_subnet_id, var.obtsync_app_service_subnet_id, var.appgatway_subnet_id]
}

resource "null_resource" "app_authentication" {
  depends_on = [azurerm_app_service.utility_app_service, azurerm_app_service.timeseries_api_app_service, azurerm_app_service.obtsync_app_service]
  provisioner "local-exec" {
    command = "sleep 3m"
  }
  provisioner "local-exec" {
    command = "az resource create -g ${var.rg_obuoc_name} --resource-type 'Microsoft.Web/sites/config' -n ${azurerm_app_service.webui_app_service.name} --properties '{\"siteConfig\": { \"metadata\": [{\"name\":\"CURRENT_STACK\",\"value\":\"dotnet\"}] }}'"
  }
  provisioner "local-exec" {
    command = "az resource create -g ${var.rg_obuoc_name} --resource-type 'Microsoft.Web/sites/config' -n ${azurerm_app_service.obtsync_app_service.name} --properties '{\"siteConfig\": { \"metadata\": [{\"name\":\"CURRENT_STACK\",\"value\":\"dotnet\"}] }}'"
  }
  provisioner "local-exec" {
    command = "az config set extension.use_dynamic_install=yes_without_prompt"
  }
  provisioner "local-exec" {
    command = "az webapp auth microsoft update -g ${var.rg_obuoc_name} --name ${azurerm_app_service.utility_app_service.name} --client-id ${var.client_id} --client-secret ${var.client_secret} --issuer ${var.issuer_uri} --allowed-audiences ${var.audience} -y"
  }
  provisioner "local-exec" {
    command = "az webapp auth microsoft update -g ${var.rg_obuoc_name} --name ${azurerm_app_service.timeseries_api_app_service.name} --client-id ${var.client_id} --client-secret ${var.client_secret} --issuer ${var.issuer_uri} --allowed-audiences ${var.audience} -y "
  }
  provisioner "local-exec" {
    command = "az webapp auth microsoft update -g ${var.rg_obuoc_name} --name ${azurerm_app_service.obtsync_app_service.name} --client-id ${var.client_id} --client-secret ${var.client_secret} --issuer ${var.issuer_uri} --allowed-audiences ${var.audience} -y"
  }
}

resource "azurerm_function_app" "windows_function_apps" {
  depends_on = [azurerm_app_service_plan.windows_app_service_plan]
  name                       = "${var.windows_function_app_names}-${var.environment}-${var.suffix}"
  location                   = var.rg_obuoc_location
  resource_group_name        = var.rg_obuoc_name
  app_service_plan_id        = azurerm_app_service_plan.windows_app_service_plan.id
  storage_account_name       = var.core_storageaccount_name
  storage_account_access_key = var.core_storage_account_primary_access_key
  version                    = "~4"
  https_only                 = true

  site_config {
    dotnet_framework_version = "v6.0"
    always_on                = true
    min_tls_version           = "1.2"
    ftps_state = "Disabled"
    use_32_bit_worker_process = false
    cors {
        allowed_origins      = ["*"]
    }
  }
  
  identity{
    type                     = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.ai_instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.ai_connection_string
    "AzureWebJobsDashboard" = "DefaultEndpointsProtocol=https;AccountName=stuoccoretestustdwe1;AccountKey=+7nm74io7sLEAWYvvi5X3HD8zAyGvC+4zrNiHznwtNagTj9bMT8R5hJ7Y+Bvm01ascOy12t0ymWOyoM/0eefeQ==;EndpointSuffix=core.windows.net"
    "AzureWebJobsStorage" = "DefaultEndpointsProtocol=https;AccountName=stuoccoretestustdwe1;AccountKey=+7nm74io7sLEAWYvvi5X3HD8zAyGvC+4zrNiHznwtNagTj9bMT8R5hJ7Y+Bvm01ascOy12t0ymWOyoM/0eefeQ==;EndpointSuffix=core.windows.net"
    "FUNCTIONS_EXTENSION_VERSION" = "~4"
    "WEBSITE_VNET_ROUTE_ALL" = "1"  
    "OBTHubConnectionString" = "@Microsoft.KeyVault(SecretUri=${var.evh_obuoc_telemetry_readonly})"
    "OBConsumerGroupName" = var.ob_consumer_groups
    "OBEventHubName" = "${var.ob_eventhubs}-${var.environment}-${var.suffix}"
    //"TelemetryEventhubConnString" = "@Microsoft.KeyVault(SecretUri=${var.evh_obuoc_telemetry_write})"
    //"TelemetryEventhubName" = var.telemetryeventhubname
    "UNISTAD_ENTITIES_POSTGRES_CONNECTION_STRING" = "@Microsoft.KeyVault(SecretUri=${var.pgsql_obuoc_entity_evproc_conn_string})"
    "UNISTAD_EVENTS_POSTGRES_CONNECTION_STRING " = "@Microsoft.KeyVault(SecretUri=${var.pgsql_obuoc_events_evproc_conn_string})"
    "WEBSITE_DNS_SERVER" = var.website_dns_server
    "AzureFunctionsJobHost__logging__logLevel__Function" = "Debug"
    "OpenIdEndpoint" = "@Microsoft.KeyVault(SecretUri=${var.endpoint})"
    "ValidIssuer" = "@Microsoft.KeyVault(SecretUri=${var.issuer})"
    "ValidAudience" = var.valid_audiences
    "SignalRConnection" = var.signalr_connection_string
    "SignalRHubName" = "Events"
    "SAStorageAccountConnectionString" = "@Microsoft.KeyVault(SecretUri=${var.uoc_core_sa_conn_string})"
    "SAContainerName" = var.core_sa_container_names
    "SARuleFileName" = "Rules.Json"
    "SAInvalidateCacheInDays" = "30"
    "SACacheKeyName" = "RulesConfig"
    "ADX_TABLENAME" = "telemetry"
    "ADX_DBNAME" =  "${var.azurerm_kusto_database_name}"
    "ADX_APPKEY" = "@Microsoft.KeyVault(SecretUri=${var.msal_client_secret})"
    "ADX_APPID"  = var.adx_app_id
    "ADX_CLUSTERPATH" = var.adx_connection_string
    "ADX_APPTENANT" = var.tenant_id
    //"teleConnectionString" = "@Microsoft.KeyVault(SecretUri=${var.evh_obuoc_telemetry_write})"
    //"teleConsumerGroupName" = var.tele_consumer_group
    //"teleEventHubName" = var.tele_eventhub
    "ConnectorComponentIdsForWindSpeed" = "CC_ID_1,CC_ID_2"
    "ConnectorComponentIdsForPitch" = "CC_ID_1,CC_ID_2"
    "ConnectorComponentsInterval"   =  "60000"
  }

  tags                       = var.tags
}


resource "azurerm_app_service_virtual_network_swift_connection" "windows_function_app_virtual_network_swift_connections" {
  depends_on = [azurerm_function_app.windows_function_apps]
  app_service_id      = azurerm_function_app.windows_function_apps.id
  subnet_id           = var.windows_app_service_subnet_id
}

resource "azurerm_key_vault_access_policy" "windows_kv_accesspolicys" {
  depends_on = [azurerm_function_app.windows_function_apps]
  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_function_app.windows_function_apps.identity[0].tenant_id
  object_id    = azurerm_function_app.windows_function_apps.identity[0].principal_id

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

/*resource "azurerm_storage_account_network_rules" "core_network_rules_Deny_testss" {
  depends_on = [azurerm_function_app.windows_function_apps]
  resource_group_name        = var.rg_obuoc_name
  storage_account_name = var.core_storageaccount_name

  default_action             = "Deny"
  virtual_network_subnet_ids = [var.azureservices_subnet_id, var.linux_app_service_subnet_id, var.windows_app_service_subnet_id, var.obtsync_app_service_subnet_id, var.appgatway_subnet_id]
}*/