
resource "azurerm_resource_group" "rg_spoke" {
  name     = "rg-${var.workload}-spoke-${var.environment}-${var.location}-002"
  location = var.location
}

#########
# NETWORK
#########

# SPOKE VNET
resource "azurerm_virtual_network" "vnet_spoke" {
  name                = "vnet-${var.workload}-spoke-${var.environment}-${var.location}-002"
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.rg_spoke.location
  resource_group_name = azurerm_resource_group.rg_spoke.name
}

# AKS SNET
resource "azurerm_subnet" "snet1" {
  name                 = "snet-${var.workload}-${var.environment}-${var.location}-002"
  resource_group_name  = azurerm_resource_group.rg_spoke.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke.name
  address_prefixes     = [var.snet_cidr_aks]
}

# ENDPOINTS SNET
resource "azurerm_subnet" "snet2" {
  name                 = "snet-${var.workload}-${var.environment}-${var.location}-003"
  resource_group_name  = azurerm_resource_group.rg_spoke.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke.name
  address_prefixes     = [var.snet_cidr_endpoints]
}

#DB SNET
resource "azurerm_subnet" "snet3" {
name                   = "snet-${var.workload}-${var.environment}-${var.location}-004"
  resource_group_name  = azurerm_resource_group.rg_spoke.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke.name
  address_prefixes     = [var.snet_cidr_db]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "postgresql-delegation"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# JUMPBOX SNET
resource "azurerm_subnet" "snet4" {
  name                 = "snet-${var.workload}-${var.environment}-${var.location}-005"
  resource_group_name  = azurerm_resource_group.rg_spoke.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke.name
  address_prefixes     = [var.snet_cidr_jumpbox]
}