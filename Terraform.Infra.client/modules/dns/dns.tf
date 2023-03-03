resource "azurerm_private_dns_zone" "storageAccount" {
  for_each            = toset(var.storage_zone)
  name                = each.key
  resource_group_name = var.rg_obuoc_name
}
resource "azurerm_private_dns_zone_virtual_network_link" "privateLink-sa" {
  for_each              = toset(var.storage_zone)
  name                  = each.key
  resource_group_name   = var.rg_obuoc_name
  private_dns_zone_name = azurerm_private_dns_zone.storageAccount[each.key].name
  virtual_network_id    = var.vnet_id
  tags = var.tags
}

resource "azurerm_private_dns_zone" "appservice" {
  name                = var.app_zone
  resource_group_name = var.rg_obuoc_name
}
resource "azurerm_private_dns_zone_virtual_network_link" "privateLink-app" {
  name                  = var.app_zone
  resource_group_name   = var.rg_obuoc_name
  private_dns_zone_name = azurerm_private_dns_zone.appservice.name
  virtual_network_id    = var.vnet_id
  tags = var.tags
}

resource "azurerm_private_dns_zone" "keyVault" {
  name                = var.keyvault_zone
  resource_group_name = var.rg_obuoc_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privateLink-kv" {
  name                  = var.keyvault_zone
  resource_group_name   = var.rg_obuoc_name
  private_dns_zone_name = azurerm_private_dns_zone.keyVault.name
  virtual_network_id    = var.vnet_id
  tags = var.tags
}

resource "azurerm_private_dns_zone" "postgresql" {
  name                = var.postgresql_zone
  resource_group_name = var.rg_obuoc_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privateLink-ps" {
  name                  = var.postgresql_zone
  resource_group_name   = var.rg_obuoc_name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = var.vnet_id
  tags = var.tags
}

resource "azurerm_private_dns_zone" "eventHub" {
  name                = var.eventhub_zone
  resource_group_name = var.rg_obuoc_name
}
resource "azurerm_private_dns_zone_virtual_network_link" "privateLink-eh" {
  name                  = var.eventhub_zone
  resource_group_name   = var.rg_obuoc_name
  private_dns_zone_name = azurerm_private_dns_zone.eventHub.name
  virtual_network_id    = var.vnet_id
  tags = var.tags
}

resource "azurerm_private_dns_zone" "kusto" {
  name                = var.kusto_zone
  resource_group_name = var.rg_obuoc_name
}
resource "azurerm_private_dns_zone_virtual_network_link" "privateLink-kusto" {
  name                  = var.kusto_zone
  resource_group_name   = var.rg_obuoc_name
  private_dns_zone_name = azurerm_private_dns_zone.kusto.name
  virtual_network_id    = var.vnet_id
  tags = var.tags
}
