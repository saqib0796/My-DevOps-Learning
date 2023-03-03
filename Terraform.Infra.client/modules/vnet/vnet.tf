resource "azurerm_virtual_network" "obuoc_vnet" {
  name                = "${var.obuoc_vnet_name}-${var.environment}-${var.suffix}"
  location            = var.rg_obuoc_location
  resource_group_name = var.rg_obuoc_name
  address_space       = [var.obuoc_vnet_address]
  tags                = var.tags
}

resource "azurerm_subnet" "azureservices_subnet" {
  name                 = "${var.azureservices_subnet_name}-${var.environment}-${var.suffix}"
  address_prefixes     = [var.azureservices_subnet_address]
  resource_group_name  = azurerm_virtual_network.obuoc_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.obuoc_vnet.name
  enforce_private_link_endpoint_network_policies = true
  service_endpoints    = [
    "Microsoft.Sql", 
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.Storage",
    "Microsoft.Web",
    "Microsoft.ServiceBus"
  ]
  depends_on = [azurerm_virtual_network.obuoc_vnet]
}

resource "azurerm_subnet" "linux_app_service_subnet" {
  name                 = "${var.linux_app_service_subnet_name}-${var.environment}-${var.suffix}"
  address_prefixes     = [var.linux_app_service_subnet_address]
  resource_group_name  = azurerm_subnet.azureservices_subnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.obuoc_vnet.name
  enforce_private_link_endpoint_network_policies = true
  service_endpoints    = [
    "Microsoft.Sql", 
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.Storage",
    "Microsoft.Web",
    "Microsoft.ServiceBus"
  ]

  delegation {
    name = "${var.linux_app_service_subnet_name}-${var.environment}-${var.suffix}-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }

  }

  depends_on = [azurerm_virtual_network.obuoc_vnet, azurerm_subnet.azureservices_subnet]
}

resource "azurerm_subnet" "windows_app_service_subnet" {
  name                 = "${var.windows_app_service_subnet_name}-${var.environment}-${var.suffix}"
  address_prefixes     = [var.windows_app_service_subnet_address]
  resource_group_name  = azurerm_subnet.linux_app_service_subnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.obuoc_vnet.name
  enforce_private_link_endpoint_network_policies = true
  service_endpoints    = [
    "Microsoft.Sql", 
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.Storage",
    "Microsoft.Web",
    "Microsoft.ServiceBus"
  ]

  delegation {
    name = "${var.windows_app_service_subnet_name}-${var.environment}-${var.suffix}-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }

  }

  depends_on = [azurerm_virtual_network.obuoc_vnet, azurerm_subnet.azureservices_subnet, azurerm_subnet.linux_app_service_subnet]
}

resource "azurerm_subnet" "obtsync_app_service_subnet" {
  name                 = "${var.obtsync_app_service_subnet_name}-${var.environment}-${var.suffix}"
  address_prefixes     = [var.obtsync_app_service_subnet_address]
  resource_group_name  = azurerm_subnet.windows_app_service_subnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.obuoc_vnet.name
  enforce_private_link_endpoint_network_policies = true
  service_endpoints    = [
    "Microsoft.Sql", 
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.Storage",
    "Microsoft.Web",
    "Microsoft.ServiceBus"
  ]

  delegation {
    name = "${var.obtsync_app_service_subnet_name}-${var.environment}-${var.suffix}-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }

  }

  depends_on = [azurerm_virtual_network.obuoc_vnet, azurerm_subnet.azureservices_subnet, azurerm_subnet.linux_app_service_subnet, azurerm_subnet.windows_app_service_subnet]
}

resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "${var.agw_subnet_name}-${var.environment}-${var.suffix}"
  address_prefixes     = [var.appgw_subnet_address]
  resource_group_name  = azurerm_subnet.obtsync_app_service_subnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.obuoc_vnet.name
  enforce_private_link_endpoint_network_policies = true
  service_endpoints    = [
    "Microsoft.Sql", 
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.Storage",
    "Microsoft.Web",
    "Microsoft.ServiceBus"
  ]
  depends_on = [azurerm_virtual_network.obuoc_vnet, azurerm_subnet.azureservices_subnet, azurerm_subnet.linux_app_service_subnet, azurerm_subnet.windows_app_service_subnet, azurerm_subnet.obtsync_app_service_subnet]
}

/*resource "null_resource" "wait_subnet_service_endpoint_creation" {
  provisioner "local-exec" {
    command = "sleep 2m"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.azureservices_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Sql"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.azureservices_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.EventHub"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.azureservices_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.KeyVault"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.azureservices_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Storage"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.azureservices_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Web"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.azureservices_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.ServiceBus"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.linux_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Sql"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.linux_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.EventHub"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.linux_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.KeyVault"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.linux_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Storage"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.linux_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Web"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.linux_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.ServiceBus"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.windows_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Sql"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.windows_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.EventHub"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.windows_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.KeyVault"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.windows_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Storage"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.windows_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Web"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.windows_app_service_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.ServiceBus"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.app_gateway_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Sql"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.app_gateway_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.EventHub"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.app_gateway_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.KeyVault"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.app_gateway_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Storage"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.app_gateway_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.Web"
  }
  provisioner "local-exec" {
    command = "az network vnet subnet update -g ${var.rg_obuoc_name} -n ${azurerm_subnet.app_gateway_subnet.name} --vnet-name ${azurerm_virtual_network.obuoc_vnet.name} --service-endpoints Microsoft.ServiceBus"
  }
}*/
