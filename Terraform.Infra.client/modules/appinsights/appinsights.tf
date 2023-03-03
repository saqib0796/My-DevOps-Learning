resource "azurerm_application_insights" "appinsights" {
  name                = "${var.appinsights_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  workspace_id        = var.loganalyticsworkspace_id
  application_type    = "web"
  tags = var.tags
}

resource "azurerm_application_insights" "user_audit_appinsights" {
  name                = "${var.user_audit_appinsights_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  workspace_id        = var.loganalyticsworkspace_id
  application_type    = "web"
  tags = var.tags
}
