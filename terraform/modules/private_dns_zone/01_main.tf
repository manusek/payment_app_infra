resource "azurerm_private_dns_zone" "acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.rg_name
}

# ŁĄCZY DNS ZONE Z VNET 
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "dns_to_spoke"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.acr.name
  virtual_network_id    = var.spoke_vnet_id
}

# MAPOWANIE NAZWY DOMENY NA IP
resource "azurerm_private_dns_a_record" "acr" {
  name                = var.acr_name
  zone_name           = azurerm_private_dns_zone.acr.name
  resource_group_name = var.rg_name
  ttl                 = 300
  records             = [var.pep_private_ip]
}