###################
# DNS ZONE FOR ACR
###################

resource "azurerm_private_dns_zone" "acr_private_dns_zone" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.rg_name
}

# ŁĄCZY DNS ZONE Z VNET 
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link_acr" {
  name                  = "vnet_link_acr"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.acr_private_dns_zone.name
  virtual_network_id    = var.spoke_vnet_id
}

# MAPOWANIE NAZWY DOMENY NA IP
resource "azurerm_private_dns_a_record" "acr_a_record" {
  name                = var.acr_name
  zone_name           = azurerm_private_dns_zone.acr_private_dns_zone.name
  resource_group_name = var.rg_name
  ttl                 = 300
  records             = [var.acr_pep_private_ip]
}


##########################
# DNS ZONE FOR  KEY VAULT
##########################

resource "azurerm_private_dns_zone" "kv_private_dns_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.rg_name
}

# Łączymy strefę DNS z naszą siecią wirtualną
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link_kv" {
  name                  = "vnet-link-kv"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.kv_private_dns_zone.name
  virtual_network_id    = var.spoke_vnet_id
}

resource "azurerm_private_dns_a_record" "kv_a_record" {
  name                = var.kv_name
  zone_name           = azurerm_private_dns_zone.kv_private_dns_zone.name
  resource_group_name = var.rg_name
  ttl                 = 300
  records             = [var.kv_pep_private_ip]
}
