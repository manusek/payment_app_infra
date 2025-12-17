resource "azurerm_public_ip" "pip" {
  name                = "pip-${var.workload}-${var.environment}-${var.location}-001"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

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
# NAT RULES
############

resource "azurerm_firewall_nat_rule_collection" "dnat" {
  name                = "dnat-${var.workload}-${var.environment}-${var.location}-001"
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "dnat_firewall_to_lb"

    # INTERNET
    source_addresses = [
      "0.0.0.0/0",
    ]

    # PORTY NA KTORE PRZYCHODZI RUCH Z INTERNETU
    destination_ports = [
      "443",
    ]

    # PUBLICZNY ADRES FIREWALL 
    destination_addresses = [
      azurerm_public_ip.pip.ip_address
    ]

    # PORT NA KTORY MA TRAFIAC WEWNATRZ SIECI
    translated_port = 443

    # ADRES LB AKS
    # TODO: ZMIENIC TO NA PRAWDZIWY ADRES PO UTWORZENIU AKS, POKI CO ADRES JEST PRZYKLADOWY
    translated_address = "10.10.10.10./1"

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}
