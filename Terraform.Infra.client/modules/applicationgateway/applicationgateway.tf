resource "azurerm_public_ip" "agw_public_ip" {
  name                = "${var.agw_public_ip_address_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_address_sku
  tags = var.tags
}

resource "azurerm_application_gateway" "appgw_network" {
  name                = "${var.agw_name}-${var.environment}-${var.suffix}"
  resource_group_name = var.rg_obuoc_name
  location            = var.rg_obuoc_location

  lifecycle {
    ignore_changes = [
      http_listener,
      request_routing_rule,
      probe,
      backend_http_settings,
      frontend_port,
    ]
  }

  sku {
    name     = var.app_gateway_sku_name
    tier     = var.app_gateway_sku_tier
  }

  autoscale_configuration {
    min_capacity = "1"
    max_capacity = var.app_gateway_sku_capacity
  }

  /*waf_configuration {
    enabled          = "true"
    firewall_mode    = "Detection"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"
  }*/
  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.appgatway_subnet_id
  }

  frontend_port {
    name = var.frontend_port_name
    port = 80
  }

  # frontend_ip_configuration {
  #  name                 = local.frontend_ip_configuration_name
  #  public_ip_address_id = azurerm_public_ip.agw_public_ip.id
  # }

 frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.agw_public_ip.id
    # subnet_id = module.shared.appgatway_subnet_id
    # private_ip_address_allocation = "Static"
    # private_ip_address = "172.19.92.135"
  }

  backend_address_pool {
    name = var.backend_address_pool_name_webui
    fqdns = [var.webui_app_service_default_site_hostname]
  }

  backend_address_pool {
    name = var.backend_address_pool_name_obtsync
    fqdns = [var.obtsync_app_service_default_site_hostname]
  }

  backend_address_pool {
    name = var.backend_address_pool_name_timeseries_api
    fqdns = [var.timeseries_api_app_service_default_site_hostname]
  }

  backend_address_pool {
    name = var.backend_address_pool_name_graphql_entity
    fqdns = [var.graphql_entity_app_service_default_site_hostname]
  }

  backend_address_pool {
    name = var.backend_address_pool_name_graphql_event
    fqdns = [var.graphql_event_app_service_default_site_hostname]
  }

  backend_address_pool {
    name = var.backend_address_pool_name_utility
    fqdns = [var.utility_app_service_default_site_hostname]
  }

  backend_address_pool {
    name = var.backend_address_pool_name_storage
    fqdns = [var.storage_app_service_default_site_hostname]
  }

  backend_address_pool {
    name = var.backend_address_pool_name_eventhub_telemetry
    fqdns = [var.eventhub_telemetry_app_service_default_site_hostname]
  }

  backend_address_pool {
    name = var.backend_address_pool_name_eventprocessor
    fqdns = [var.eventprocessor_functionapp_default_site_hostname]
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name_webui
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    path                  = "/"
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name_obtsync
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    path                  = "/"
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name_timeseries_api
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    path                  = "/"
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name_graphql_entity
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    path                  = "/"
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name_graphql_event
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    path                  = "/"
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name_utility
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    path                  = "/"
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name_storage
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    path                  = "/"
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name_eventhub_telemetry
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    path                  = "/"
    pick_host_name_from_backend_address = true
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name_eventprocessor
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    path                  = "/"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Http" #"Https" with Azure Key Vault cert pending fix add https://github.com/terraform-providers/terraform-provider-azurerm/issues/3935
    //ssl_certificate_name = local.certificate_name
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = "PathBasedRouting"
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name_webui
    backend_http_settings_name = var.backend_http_settings_name_webui #local.http_setting_name
    url_path_map_name          = var.rule_name
  }
  
  url_path_map {
    name = var.rule_name
    default_backend_address_pool_name = var.backend_address_pool_name_webui
    default_backend_http_settings_name = var.backend_http_settings_name_webui

    path_rule {
      name = var.path_name_obtsync
      paths = [var.route_obtsync]
      backend_address_pool_name = var.backend_address_pool_name_obtsync
      backend_http_settings_name = var.backend_http_settings_name_obtsync
    }
    path_rule {
      name = var.path_name_graphqlevent
      paths = [var.route_graphqlevent]
      backend_address_pool_name = var.backend_address_pool_name_graphql_event
      backend_http_settings_name = var.backend_http_settings_name_graphql_event
    }
    path_rule {
      name = var.path_name_graphqlentity
      paths = [var.route_graphqlentity]
      backend_address_pool_name = var.backend_address_pool_name_graphql_entity
      backend_http_settings_name = var.backend_http_settings_name_graphql_entity
    }
    path_rule {
      name = var.path_name_storage
      paths = [var.route_storage]
      backend_address_pool_name = var.backend_address_pool_name_storage
      backend_http_settings_name = var.backend_http_settings_name_storage
    }
    path_rule {
      name = var.path_name_utility
      paths = [var.route_utility]
      backend_address_pool_name = var.backend_address_pool_name_utility
      backend_http_settings_name = var.backend_http_settings_name_utility
    }
    path_rule {
      name = var.path_name_timeseriesapi
      paths = [var.route_timeseriesapi]
      backend_address_pool_name = var.backend_address_pool_name_timeseries_api
      backend_http_settings_name = var.backend_http_settings_name_timeseries_api
    }
    path_rule {
      name = var.path_name_eventhub_telemetry
      paths = [var.route_eventhub_telemetry]
      backend_address_pool_name = var.backend_address_pool_name_eventhub_telemetry
      backend_http_settings_name = var.backend_http_settings_name_eventhub_telemetry
    }
    path_rule {
      name = var.path_name_eventprocessor
      paths = [var.route_eventprocessor]
      backend_address_pool_name = var.backend_address_pool_name_eventprocessor
      backend_http_settings_name = var.backend_http_settings_name_eventprocessor
    }
  }
  # ssl_certificate{
  #   name = local.certificate_name
  #   key_vault_secret_id = data.azurerm_key_vault_certificate.data-cert-agw.certificate #azurerm_key_vault_certificate.akv_cert.secret_id #v 2.2.0 required
  # }

  # ssl_certificate{
  #   name = local.certificate_name
  #   data =  filebase64(var.certPath)
  #   password = var.agw_cert_pwd
  # }

  tags = var.tags
}


