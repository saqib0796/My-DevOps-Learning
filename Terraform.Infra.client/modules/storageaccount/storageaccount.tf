resource "azurerm_storage_account" "core_sa" {
  name                     = "${var.core_storageaccount_name}${var.environment}${var.suffix}"
  resource_group_name      = var.rg_obuoc_name
  location                 = var.rg_obuoc_location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "GRS"

  /*network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.azureservices_subnet_id, var.linux_app_service_subnet_id, var.windows_app_service_subnet_id, var.appgatway_subnet_id]
  }*/

  tags                     = var.tags
}

resource "azurerm_storage_container" "core_sa_container" {
  name                  = var.core_sa_container_names
  storage_account_name  = azurerm_storage_account.core_sa.name
  container_access_type = "private"
  //count                 = length(var.core_sa_container_names)
}

resource "azurerm_storage_account" "tsdbtm" {
  name                     = "${var.tsdbtm_storageaccount_name}${var.environment}${var.suffix}"
  resource_group_name      = var.rg_obuoc_name
  location                 = var.rg_obuoc_location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "GRS"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.azureservices_subnet_id, var.linux_app_service_subnet_id, var.windows_app_service_subnet_id, var.obtsync_app_service_subnet_id, var.appgatway_subnet_id]
  }

  tags                     = var.tags
}

resource "azurerm_storage_account" "cdn_sa" {
  name                     = "${var.cdn_storageaccount_name}${var.environment}${var.suffix}"
  resource_group_name      = var.rg_obuoc_name
  location                 = var.rg_obuoc_location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "GRS"
  allow_blob_public_access = true
  static_website {
    index_document         = "$web"
    error_404_document     = "404.html"
  }
  blob_properties{
    cors_rule {
      allowed_headers      = ["*"]
      allowed_methods      = ["GET", "OPTIONS", "HEAD"]
      allowed_origins      = ["*"]
      exposed_headers      = ["*"]
      max_age_in_seconds   = 86400
    }
  }

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.azureservices_subnet_id, var.linux_app_service_subnet_id, var.windows_app_service_subnet_id, var.obtsync_app_service_subnet_id, var.appgatway_subnet_id]
  }

  tags                      = var.tags
}

resource "azurerm_storage_container" "uoc_event_archive" {
  name                  = var.core_sa_event_archive_container_name
  storage_account_name  = azurerm_storage_account.core_sa.name
  container_access_type = "private"
}