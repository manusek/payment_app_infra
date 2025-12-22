
resource "azurerm_resource_group" "rg_hub" {
  name     = "rg-${var.workload}-hub-${var.environment}-${var.location}-001"
  location = var.location
}

#########
# NETWORK
#########

# HUB VNET
resource "azurerm_virtual_network" "vnet_hub" {
  name                = "vnet-${var.workload}-${var.environment}-${var.location}-001"
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.rg_hub.location
  resource_group_name = azurerm_resource_group.rg_hub.name
}

# FIREWALL SNET
resource "azurerm_subnet" "snet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg_hub.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.snet_cidr_firewall]
}

# BASTION HOST SNET
resource "azurerm_subnet" "snet_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg_hub.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.snet_cidr_bastion]
}

