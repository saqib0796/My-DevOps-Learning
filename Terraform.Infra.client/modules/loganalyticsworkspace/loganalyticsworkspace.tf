resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.law_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  sku                 = "PerGB2018"
  tags                = var.tags
}