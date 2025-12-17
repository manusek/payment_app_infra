# Hub -> Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "hub-to-spoke"
  resource_group_name       = azurerm_resource_group.rg_hub.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke.id

  allow_forwarded_traffic = true     # przepuszcza ruch do/z Spoke
  allow_gateway_transit   = true     # pozwala Spoke używać Hub jako bramki
  use_remote_gateways     = false    # Hub nie używa bramki zdalnej, ma własną
}

# Spoke -> Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "spoke-to-hub"
  resource_group_name       = azurerm_resource_group.rg_spoke.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id

  allow_forwarded_traffic = true   # przepuszcza ruch przychodzący z Hub do lokalnych subnetów
  allow_gateway_transit   = false  # Spoke nie udostępnia swojej bramki innym sieciom
  use_remote_gateways     = true   # Spoke używa bramki w Hub (np. firewall do internetu)
}