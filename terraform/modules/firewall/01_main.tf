############
# PUBLIC IP
############

resource "azurerm_public_ip" "pip" {
  name                = "pip-${var.workload}-${var.environment}-${var.location}-001"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}


############
# FIREWALL
############

resource "azurerm_firewall" "afw" {
  name                = "afw-${var.workload}-${var.environment}-${var.location}-001"
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku_name            = "AZFW_Hub"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.snet_id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}


############
# FIREWALL POLICY 
############

resource "azurerm_firewall_policy" "afwp" {
  name                = "afwp-${var.workload}-${var.environment}-${var.location}-001"
  resource_group_name = var.rg_name
  location            = var.rg_location
}


############
# POLICY RULES
############

resource "azurerm_firewall_policy_rule_collection_group" "example" {
  name               = "rcg-${var.workload}-${var.environment}-${var.location}-001"
  firewall_policy_id = azurerm_firewall_policy.afwp.id
  priority           = 500
  
  nat_rule_collection {
    name     = "dnat_firewall_to_aks"
    priority = 300
    action   = "Dnat"
    rule {
      name                = "dnat_rule1"
      protocols           = ["TCP", "UDP"]
      source_addresses    = ["0.0.0.0/0"]
      destination_address = azurerm_public_ip.pip.ip_address
      destination_ports   = ["443"]
      # ADRES INTERNAL LB DLA AKS - ADRES WPISANY TESTOWO DO ZMIANY W PRZYSZLOSCI
      translated_address  = "192.168.0.1"
      translated_port     = "443"
    }
  }
}