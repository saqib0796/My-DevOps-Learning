/*resource "null_resource" "sleep" {
  provisioner "local-exec" {
    command = "sleep 10m"
  }
}*/

resource "azurerm_postgresql_server" "entity_server" {
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                = "${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix}"
  resource_group_name      = var.rg_obuoc_name
  location                 = var.rg_obuoc_location
  sku_name     = var.postgresql_sku_name
  storage_mb            = var.postgresql_storage_mb
  backup_retention_days = var.postgresql_backup_retention_days
  geo_redundant_backup_enabled = var.postgresql_geo_redundant_backup
  administrator_login          = var.pdb_admin_login_akv_key
  administrator_login_password = var.pdb_admin_pwd_akv_key
  version                      = var.postgresql_server_version
  ssl_enforcement_enabled      = var.postgresql_ssl_enforcement
  public_network_access_enabled    = false
  threat_detection_policy {
  enabled = true
  }

  tags = var.tags
  //depends_on = [null_resource.sleep]
}


resource "null_resource" "postgresql-entity-read-replica" {
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  depends_on = [azurerm_postgresql_server.entity_server]
  provisioner "local-exec" {
    command = "az postgres server replica create -n ${var.azure_entity_postgresql_name}-${var.environment}-${var.prod_replica_suffix} -g ${var.rg_obuoc_name} -s /subscriptions/${var.subscription_id}/resourceGroups/${var.rg_obuoc_name}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix} -l northeurope"
       //depends_on = [null_resource.sleep]       
  }
}



/*resource "null_resource" "postgresql-entity-read-replica" {
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  depends_on = [azurerm_postgresql_server.events_server]
  provisioner "local-exec" {
    command = "az postgres server replica create -n ${var.azure_entity_postgresql_name}-${var.environment}-${var.prod_replica_suffix} -g ${var.rg_obuoc_name} -s /subscriptions/${var.subscription_id}/resourceGroups/${var.rg_obuoc_name}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix} -l northeurope"
  }
}*/

/*resource "null_resource" "postgresql-entity-read-replica" {
  count = var.rg_obuoc_location == "northeurope" ? 1 : 0
  depends_on = [azurerm_postgresql_server.entity_server]
  provisioner "local-exec" {
    command = <<-EOT
              az login --service-principal -u ${var.subscription_id} -p ${var.terrclient_secret} --tenant ${var.tenant_id};
              az account set --subscription ${var.prod_replica_subscription_id};
              az postgres server replica create -n ${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix} -g terraform-rg-dev-ne0016 -s /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.prod_replica_environment}-${var.prod_replica_suffix} -l northeurope;
              az resource move --destination-group terraform-rg-dev-ne0016 --ids /subscriptions/5424b909-d19a-4a13-ac66-4b6670fa4f1c/resourceGroups/terraform-rg-dev-we0016/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix} --destination-subscription-id 6148f5ae-8cc1-498f-ac0c-899ce53f311f --subscription 5424b909-d19a-4a13-ac66-4b6670fa4f1c;
              az account set --subscription UNISTAD-DEVTEST
    EOT
  }
}*/

/*resource "null_resource" "postgresql-entity-read-replica" {
  count = var.rg_obuoc_location == "northeurope" ? 1 : 0
  //depends_on = [azurerm_postgresql_server.events_server]
  provisioner "local-exec" {
    command = "az postgres server replica create -n ${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix} -g /subscriptions/01d8cdbf-3559-4189-890b-c6cdf124d094/resourceGroups/rg-obuoc-prod-unistad-we1 -s /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.environment}-${var.prod_replica_suffix} -l northeurope;"
  }
}*/

/*resource "null_resource" "postgresql-read-replica-entity-migration" {
  count = var.rg_obuoc_location == "northeurope" ? 1 : 0
  //depends_on = [null_resource.postgresql-entity-read-replica]
    provisioner "local-exec" {
    command = "az resource move --destination-group ${var.rg_obuoc_name} --ids /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.prod_replica_environment}-${var.suffix} --destination-subscription-id ${var.subscription_id} --subscription ${var.prod_replica_subscription_id};"
    /*command = <<-EOT 
              az postgres server replica create -n ${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix} -g ${var.prod_replica_resource_group} -s /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.environment}-${var.prod_replica_suffix} -l northeurope;
              az resource move --destination-group ${var.rg_obuoc_name} --ids /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.prod_replica_environment}-${var.suffix} --destination-subscription-id ${var.subscription_id} --subscription ${var.prod_replica_subscription_id};
    EOT
  }
}*/


resource "azurerm_postgresql_database" "entity_dbs" {
  #count               = length(var.postgresql_db_names)
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                = var.postgresql_db_names
  resource_group_name = var.rg_obuoc_name
  server_name         = azurerm_postgresql_server.entity_server[count.index].name
  charset             = var.postgresql_db_charset
  collation           = var.postgresql_db_collation
  depends_on = [azurerm_postgresql_server.entity_server]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_entity_azureservices_subnet" {  
 count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-entity-vnet-rule-azureservices-subnet"
  resource_group_name                  = azurerm_postgresql_database.entity_dbs[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.entity_server[count.index].name
  subnet_id                            = var.azureservices_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_database.entity_dbs, azurerm_postgresql_server.entity_server]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_entity_linux_app_service_subnet" {  
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-entity-vnet-rule-linux-app-service-subnet"
  resource_group_name                  = azurerm_postgresql_virtual_network_rule.vnet_rules_entity_azureservices_subnet[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.entity_server[count.index].name
  subnet_id                            = var.linux_app_service_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_database.entity_dbs, azurerm_postgresql_server.entity_server, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_azureservices_subnet]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_entity_windows_app_service_subnet" {  
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-entity-vnet-rule-windows-app-service-subnet"
  resource_group_name                  = azurerm_postgresql_virtual_network_rule.vnet_rules_entity_linux_app_service_subnet[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.entity_server[count.index].name
  subnet_id                            = var.windows_app_service_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_database.entity_dbs, azurerm_postgresql_server.entity_server, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_azureservices_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_linux_app_service_subnet]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_entity_obtsync_app_service_subnet" {  
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-entity-vnet-rule-obtsync-app-service-subnet"
  resource_group_name                  = azurerm_postgresql_virtual_network_rule.vnet_rules_entity_windows_app_service_subnet[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.entity_server[count.index].name
  subnet_id                            = var.obtsync_app_service_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_database.entity_dbs, azurerm_postgresql_server.entity_server, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_azureservices_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_linux_app_service_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_windows_app_service_subnet]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_entity_appgatway_subnet" {  
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-entity-vnet-rule-appgatway-subnet"
  resource_group_name                  = azurerm_postgresql_virtual_network_rule.vnet_rules_entity_obtsync_app_service_subnet[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.entity_server[count.index].name
  subnet_id                            = var.appgatway_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_database.entity_dbs, azurerm_postgresql_server.entity_server, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_azureservices_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_linux_app_service_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_windows_app_service_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_entity_obtsync_app_service_subnet]
}



#Events_postgres_server
resource "azurerm_postgresql_server" "events_server" {
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                = "${var.azure_events_postgresql_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  sku_name     = var.postgresql_sku_name
  storage_mb            = var.postgresql_storage_mb
  backup_retention_days = var.postgresql_backup_retention_days
  geo_redundant_backup_enabled = var.postgresql_geo_redundant_backup
  administrator_login          = var.pdb_admin_login_akv_key
  administrator_login_password = var.pdb_admin_pwd_akv_key
  version                      = var.postgresql_server_version
  ssl_enforcement_enabled      = var.postgresql_ssl_enforcement
  public_network_access_enabled    = false
  threat_detection_policy {
  enabled = true
  }

  tags = var.tags
  //depends_on = [null_resource.sleep]
}


resource "null_resource" "postgresql-events-read-replica" {
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  depends_on = [azurerm_postgresql_server.events_server]
  provisioner "local-exec" {
    command = "az postgres server replica create -n ${var.azure_events_postgresql_name}-${var.environment}-${var.prod_replica_suffix} -g ${var.rg_obuoc_name} -s /subscriptions/${var.subscription_id}/resourceGroups/${var.rg_obuoc_name}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_events_postgresql_name}-${var.environment}-${var.suffix} -l northeurope"
              
  }
}

/*resource "null_resource" "postgresql-read-replica" {
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  depends_on = [azurerm_postgresql_server.events_server]
  provisioner "local-exec" {
    command = "az postgres server replica create -n ${var.azure_events_postgresql_name}-${var.environment}-${var.prod_replica_suffix} -g ${var.rg_obuoc_name} -s ${var.rg_obuoc_name} -s /subscriptions/${var.subscription_id}/resourceGroups/${var.rg_obuoc_name}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix} -l northeurope"
  }
  
}*/


/*resource "null_resource" "postgresql-events-read-replica" {
  count = var.rg_obuoc_location == "northeurope" ? 1 : 0
  //depends_on = [azurerm_postgresql_server.events_server]
  provisioner "local-exec" {
    command = "az postgres server replica create -n ${var.azure_events_postgresql_name}-${var.environment}-${var.suffix} -g /subscriptions/01d8cdbf-3559-4189-890b-c6cdf124d094/resourceGroups/rg-obuoc-prod-unistad-we1 -s /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_events_postgresql_name}-${var.environment}-${var.prod_replica_suffix} -l northeurope;"
  }
}*/

/*resource "null_resource" "postgresql-read-replica-events-migration" {
  count = var.rg_obuoc_location == "northeurope" ? 1 : 0
  //depends_on = [null_resource.postgresql-events-read-replica]
    provisioner "local-exec" {
    command = "az resource move --destination-group ${var.rg_obuoc_name} --ids /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_events_postgresql_name}-${var.prod_replica_environment}-${var.suffix} --destination-subscription-id ${var.subscription_id} --subscription ${var.prod_replica_subscription_id};"
    /*command = <<-EOT 
              az postgres server replica create -n ${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix} -g ${var.prod_replica_resource_group} -s /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.environment}-${var.prod_replica_suffix} -l northeurope;
              az resource move --destination-group ${var.rg_obuoc_name} --ids /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.prod_replica_environment}-${var.suffix} --destination-subscription-id ${var.subscription_id} --subscription ${var.prod_replica_subscription_id};
    EOT
  }
}*/


resource "azurerm_postgresql_database" "events_dbs" {
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  #count               = length(var.postgresql_db_names)
  name                = var.postgresql_events_db_names
  resource_group_name = var.rg_obuoc_name
  server_name         = azurerm_postgresql_server.events_server[count.index].name
  charset             = var.postgresql_db_charset
  collation           = var.postgresql_db_collation
  depends_on = [azurerm_postgresql_server.events_server]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_events_azureservices_subnet" { 
 count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-events-vnet-rule-azureservices-subnet"
  resource_group_name                  = azurerm_postgresql_database.events_dbs[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.events_server[count.index].name
  subnet_id                            = var.azureservices_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_server.events_server, azurerm_postgresql_database.events_dbs]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_events_linux_app_service_subnet" {
  count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-events-vnet-rule-linux-app-service-subnet"
  resource_group_name                  = azurerm_postgresql_virtual_network_rule.vnet_rules_events_azureservices_subnet[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.events_server[count.index].name
  subnet_id                            = var.linux_app_service_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_server.events_server, azurerm_postgresql_database.events_dbs, azurerm_postgresql_virtual_network_rule.vnet_rules_events_azureservices_subnet]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_events_windows_app_service_subnet" {  
 count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-events-vnet-rule-windows-app-service-subnet"
  resource_group_name                  = azurerm_postgresql_virtual_network_rule.vnet_rules_events_linux_app_service_subnet[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.events_server[count.index].name
  subnet_id                            = var.windows_app_service_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_server.events_server, azurerm_postgresql_database.events_dbs, azurerm_postgresql_virtual_network_rule.vnet_rules_events_azureservices_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_events_linux_app_service_subnet]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_events_obtsync_app_service_subnet" {  
 count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-events-vnet-rule-obtsync-app-service-subnet"
  resource_group_name                  = azurerm_postgresql_virtual_network_rule.vnet_rules_events_windows_app_service_subnet[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.events_server[count.index].name
  subnet_id                            = var.obtsync_app_service_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_server.events_server, azurerm_postgresql_database.events_dbs, azurerm_postgresql_virtual_network_rule.vnet_rules_events_azureservices_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_events_linux_app_service_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_events_windows_app_service_subnet]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules_events_appgatway_subnet" { 
 count = var.rg_obuoc_location == "westeurope" ? 1 : 0
  name                                 = "postgresql-events-vnet-rule-appgatway-subnet"
  resource_group_name                  = azurerm_postgresql_virtual_network_rule.vnet_rules_events_obtsync_app_service_subnet[count.index].resource_group_name
  server_name                          = azurerm_postgresql_server.events_server[count.index].name
  subnet_id                            = var.appgatway_subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [azurerm_postgresql_server.events_server, azurerm_postgresql_database.events_dbs, azurerm_postgresql_virtual_network_rule.vnet_rules_events_azureservices_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_events_linux_app_service_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_events_windows_app_service_subnet, azurerm_postgresql_virtual_network_rule.vnet_rules_events_obtsync_app_service_subnet]
}


