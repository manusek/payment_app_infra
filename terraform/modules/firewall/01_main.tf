############
# PUBLIC IP
############

resource "azurerm_public_ip" "pip_firewall" {
  name                = "pip-firewall-${var.workload}-${var.environment}-${var.location}-001"
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
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.snet_id
    public_ip_address_id = azurerm_public_ip.pip_firewall.id
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


##############
# POLICY RULES
##############

resource "azurerm_firewall_policy_rule_collection_group" "example" {
  name               = "rcg-${var.workload}-${var.environment}-${var.location}-001"
  firewall_policy_id = azurerm_firewall_policy.afwp.id
  priority           = 100
  
  nat_rule_collection {
    name     = "dnat_firewall_to_aks"
    priority = 100
    action   = "Dnat"
    rule {
      name                = "dnat_rule1"
      protocols           = ["TCP", "UDP"]
      source_addresses    = ["0.0.0.0/0"]
      destination_address = azurerm_public_ip.pip_firewall.ip_address
      destination_ports   = ["443"]
      # ADRES INTERNAL LB DLA AKS - ADRES WPISANY TESTOWO DO ZMIANY W PRZYSZLOSCI
      translated_address  = "192.168.0.1"
      translated_port     = "443"
    }
  }

network_rule_collection {
    name     = "network_rule_collection1"
    priority = 200
    action   = "Allow"
    rule {
      name                  = "AllowDNS"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["10.0.11.0/27"]
      destination_addresses = ["168.63.129.16"]
      destination_ports     = ["53"]
    }
  }

  application_rule_collection {
    name     = "app_rule_collection1"
    priority = 300
    action   = "Deny"
    rule {
      name = "app_rule_collection1_rule1"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = ["10.0.11.0/27"]
      destination_fqdns = [
        "security.ubuntu.com",
        "archive.ubuntu.com",
        "changelogs.ubuntu.com",
        "apt.postgresql.org",
        "azure.archive.ubuntu.com",
        # DODAJ TE NAZWY:
        "motd.ubuntu.com",
        "contracts.canonical.com"
      ]
    }
  }

  network_rule_collection {
    name     = "net_jumpbox_outbound_repos_final"
    priority = 250 # Miedzy DNS (200) a App (300)
    action   = "Allow"
    rule {
      name                  = "AllowUbuntuAndAzureRepos"
      protocols             = ["TCP"] # Apt uzywa TCP
      source_addresses      = ["10.0.11.0/27"]
      # source_port_ranges    = ["*"]
      # Uzywamy tagow uslug dla bezpieczenstwa i niezawodnosci:
      destination_addresses = ["AzureCloud", "Canonical", "AzureUpdate"] 
      destination_ports = ["80", "443"]
    }
  }
}