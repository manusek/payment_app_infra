# Hub -> Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "peer-hub-to-spoke-${var.workload}-${var.environment}-${var.location}-001"
  resource_group_name       = var.rg_hub_name
  virtual_network_name      = var.vnet_hub_name
  remote_virtual_network_id = var.vnet_spoke_id

  allow_forwarded_traffic = true     # przepuszcza ruch do/z Spoke
  allow_gateway_transit   = false     # pozwala Spoke używać Hub jako bramki
  use_remote_gateways     = false    # Hub nie używa bramki zdalnej, ma własną
}

# Spoke -> Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-spoke-to-hub-${var.workload}-${var.environment}-${var.location}-002"
  resource_group_name       = var.rg_spoke_name
  virtual_network_name      = var.vnet_spoke_name
  remote_virtual_network_id = var.vnet_hub_id

  allow_forwarded_traffic = true   # przepuszcza ruch przychodzący z Hub do lokalnych subnetów
  allow_gateway_transit   = false  # Spoke nie udostępnia swojej bramki innym sieciom
  use_remote_gateways     = false   # Spoke używa bramki w Hub (np. firewall do internetu)
}