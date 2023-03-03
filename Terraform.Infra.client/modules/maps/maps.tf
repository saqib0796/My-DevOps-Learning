resource "azurerm_maps_account" "maps_account" {
  name                = "maps-${var.environment}-${var.suffix}"
  resource_group_name = var.rg_obuoc_name
  sku_name            = "G2"
  tags                = var.tags
}