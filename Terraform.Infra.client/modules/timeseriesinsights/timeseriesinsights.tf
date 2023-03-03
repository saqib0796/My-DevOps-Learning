resource "azurerm_iot_time_series_insights_gen2_environment" "time_series_insights_gen2_environment" {
  name                           = "${var.time_series_insights_telemetry_name}-${var.environment}-${var.suffix}"
  location                       = var.rg_obuoc_location
  resource_group_name            = var.rg_obuoc_name
  sku_name                       = "L1"
  warm_store_data_retention_time = "P31D"
  id_properties                  = ["AssetID"]

  storage {
    name = var.tsdbtm_storageaccount_name
    key  = var.tsdbtm_storage_account_primary_access_key
  }

  tags                     = var.tags
}

resource "azurerm_iot_time_series_insights_access_policy" "time_series_insights_access_policy" {
  name                                = "${var.environment}-app-access-policy"
  time_series_insights_environment_id = azurerm_iot_time_series_insights_gen2_environment.time_series_insights_gen2_environment.id
  principal_object_id = var.app_name
  roles               = ["Reader", "Contributor"]
}

resource "azurerm_iot_time_series_insights_event_source_eventhub" "time_series_insights_event_source_eventhub" {
  name                     = var.event_source_Name
  location                 = var.rg_obuoc_location
  environment_id           = azurerm_iot_time_series_insights_gen2_environment.time_series_insights_gen2_environment.id
  eventhub_name            = var.eventhub_telemetry_name
  namespace_name           = var.azure_eventhub_namespace
  shared_access_key        = var.eventhub_telemetry_policy_listen_primary_key
  shared_access_key_name   = "readOnly"
  consumer_group_name      = var.consumer_group_names_telemetry[0]
  event_source_resource_id = var.eventhub_telemetry_id
  timestamp_property_name  = "TimeStampID"
  tags                     = var.tags
}


/*resource "null_resource" "tsdb_eventsource_telemetry" {
  provisioner "local-exec" {
    command = "az extension add --name timeseriesinsights"
  }
  provisioner "local-exec" {
    command = "az config set extension.use_dynamic_install=yes_without_prompt"
  }
  provisioner "local-exec" {
    command = "az tsi environment gen2 create --name '${var.time_series_insights_telemetry_name}-${var.environment}-${var.suffix}' --location '${var.rg_obuoc_location}' --resource-group '${var.rg_obuoc_name}' --sku name='L1' capacity=1 --time-series-id-properties name=AssetID type=String --storage-configuration account-name='${var.tsdbtm_storageaccount_name}' management-key='${var.tsdbtm_storage_account_primary_access_key}' --warm-store-config data-retention=P31D --tags ${var.cli_tags}"
  }
  provisioner "local-exec" {
    command = "sleep 1m"
  }
  provisioner "local-exec" {
    command = "az tsi event-source eventhub create --event-source-name '${var.event_source_Name}' --namespace '${var.azure_eventhub_namespace}' --environment-name '${var.time_series_insights_telemetry_name}-${var.environment}-${var.suffix}' --resource-group '${var.rg_obuoc_name}' --location '${var.rg_obuoc_location}' --consumer-group-name '${var.consumer_group_names_telemetry[0]}' --key-name 'readOnly' --shared-access-key '${var.eventhub_telemetry_policy_listen_primary_key}' --event-source-resource-id '${var.eventhub_telemetry_id}' --event-hub-name '${var.eventhub_telemetry_name}' --timestamp-property-name=TimeStampID --tags ${var.cli_tags}"
  }
  provisioner "local-exec" {
    command = "az tsi access-policy create --name '${var.environment}-app-access-policy' --environment-name '${var.time_series_insights_telemetry_name}-${var.environment}-${var.suffix}' --principal-object-id '${var.client_id}' --roles Reader Contributor --resource-group '${var.rg_obuoc_name}'"
  }
}*/