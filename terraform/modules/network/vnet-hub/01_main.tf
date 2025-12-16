
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.workload}-${var.environment}-${var.location}-001"
  location = var.location
}

#########
# NETWORK
#########

# HUB VNET
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.workload}-${var.environment}-${var.location}-001"
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# FIREWALL SNET
resource "azurerm_subnet" "snet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.snet_cidr]
}

################## 
# SECURITY GROUPS
##################

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.workload}-${var.environment}-${var.location}-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

