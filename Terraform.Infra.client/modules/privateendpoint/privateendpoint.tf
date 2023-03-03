
resource "azurerm_private_endpoint" "privateLink" {
  name                = "${var.endpointname}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  subnet_id           = var.subnet_id
  tags = var.tags

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_ids]
  }

  private_service_connection {
    name                           = var.endpointname
    is_manual_connection           = false
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = [var.subresource_names]
  }
}

