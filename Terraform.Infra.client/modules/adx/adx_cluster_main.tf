resource "azurerm_kusto_cluster" "adxcluster" {
  name                = "${var.azurerm_kusto_cluster_name}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  //auto_stop_enabled         = true
  //disk_encryption_enabled     = true
  //streaming_ingestion_enabled = true
  //purge_enabled               = true
  
  sku {
    name     = var.adx_sku_name_size
    capacity = 2
  }
    identity {
    type = "SystemAssigned"
  }
  
  tags = var.tags
  zones = ["1","3","2"]
  trusted_external_tenants = ["MyTenantOnly"]
  enable_streaming_ingest = true

}
data "azurerm_client_config" "current" {}
resource "azurerm_kusto_cluster_principal_assignment" "example" {
  name                = "KustoPrincipalAssignment"
  resource_group_name = var.rg_obuoc_name
  cluster_name        = "${var.azurerm_kusto_cluster_name}"

  tenant_id      = data.azurerm_client_config.current.tenant_id
  principal_id   = data.azurerm_client_config.current.client_id
  principal_type = "App"
  role           = "AllDatabasesAdmin"
  depends_on = [azurerm_kusto_cluster.adxcluster]
}
resource "azurerm_kusto_database" "adxdatabase" {
  name                = "${var.azurerm_kusto_database_name}"
  resource_group_name = var.rg_obuoc_name
  location            = var.rg_obuoc_location
  cluster_name        = "${var.azurerm_kusto_cluster_name}"

  hot_cache_period   = "P31D"
  soft_delete_period = "P365D"
  depends_on = [azurerm_kusto_cluster.adxcluster]
}

/*resource "azurerm_kusto_eventhub_data_connection" "eventhub_connection" {
  name                = "${var.eventhub_connection_name}"
  resource_group_name = var.rg_obuoc_name
  location            = var.rg_obuoc_location
  cluster_name        = "${var.azurerm_kusto_cluster_name}${var.suffix}"
  database_name       = "${var.azurerm_kusto_database_name}"
  eventhub_id         = "${var.eventhub_telemetery_id}"
  consumer_group      = "${var.eventhub_consumergroup_telemetery_2}"
  table_name          = "telemetry"        
  data_format         = "JSON"   
  event_system_properties = ["message-id","sequence-number","user-id"]
}*/