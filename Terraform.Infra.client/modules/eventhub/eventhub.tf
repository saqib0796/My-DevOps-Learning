resource "azurerm_eventhub_namespace" "evhns" {
  name                = "${var.azure_eventhub_namespace}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  sku                 = var.eventhub_sku
  capacity            = var.eventhub_capacity
  network_rulesets{
    default_action    = "Allow"
    trusted_service_access_enabled = true
    
    virtual_network_rule {
      subnet_id       = var.azureservices_subnet_id
      ignore_missing_virtual_network_service_endpoint = false
    }
    virtual_network_rule {
      subnet_id       = var.linux_app_service_subnet_id
      ignore_missing_virtual_network_service_endpoint = false
    }
    virtual_network_rule {
      subnet_id       = var.windows_app_service_subnet_id
      ignore_missing_virtual_network_service_endpoint = false
    }
    virtual_network_rule {
      subnet_id       = var.obtsync_app_service_subnet_id
      ignore_missing_virtual_network_service_endpoint = false
    }
    virtual_network_rule {
      subnet_id       = var.appgatway_subnet_id
      ignore_missing_virtual_network_service_endpoint = false
    }
  }

  tags = var.tags
}

resource "azurerm_eventhub" "eventhub_obtevents" {
  name                = "${var.eventhub_obtevents_name}-${var.environment}-${var.suffix}"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  resource_group_name = var.rg_obuoc_name
  partition_count     = var.eventhub_partition_count
  message_retention   = var.eventhub_message_retention
}

resource "azurerm_eventhub" "eventhub_telemetry" {
  name                = "${var.eventhub_telemetry_name}-${var.environment}-${var.suffix}"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  resource_group_name = var.rg_obuoc_name
  partition_count     = var.eventhub_partition_count
  message_retention   = var.eventhub_message_retention
}

resource "azurerm_eventhub_consumer_group" "consumer_group_obtevents_0" {
  name                = var.consumer_group_names_obtevents[0]
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.eventhub_obtevents.name
  resource_group_name = var.rg_obuoc_name
}

resource "azurerm_eventhub_consumer_group" "consumer_group_obtevents_1" {
  name                = "${var.consumer_group_names_obtevents[1]}-${var.environment}"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.eventhub_obtevents.name
  resource_group_name = var.rg_obuoc_name
}



resource "azurerm_eventhub_consumer_group" "consumer_group_telemetry_0" {
  name                = var.consumer_group_names_telemetry[0]
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetry.name
  resource_group_name = var.rg_obuoc_name
}

resource "azurerm_eventhub_consumer_group" "consumer_group_telemetry_1" {
  name                = "${var.consumer_group_names_telemetry[1]}-${var.environment}"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetry.name
  resource_group_name = var.rg_obuoc_name
}

resource "azurerm_eventhub_consumer_group" "consumer_group_telemetry_2" {
  name                = "${var.consumer_group_names_telemetry[2]}-${var.environment}"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetry.name
  resource_group_name = var.rg_obuoc_name
}

resource "azurerm_eventhub_authorization_rule" "eventhub_obtevents_policy_listen" {
  name                = "readOnly"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.eventhub_obtevents.name
  resource_group_name = var.rg_obuoc_name
  listen              = true
}
resource "azurerm_eventhub_authorization_rule" "eventhub_obtevents_policy_send" {
  name                = "write"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.eventhub_obtevents.name
  resource_group_name = var.rg_obuoc_name
  send                = true
}

resource "azurerm_eventhub_authorization_rule" "eventhub_telemetry_policy_listen" {
  name                = "readOnly"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetry.name
  resource_group_name = var.rg_obuoc_name
  listen              = true
}
resource "azurerm_eventhub_authorization_rule" "eventhub_telemetry_policy_send" {
  name                = "write"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.eventhub_telemetry.name
  resource_group_name = var.rg_obuoc_name
  send                = true
}