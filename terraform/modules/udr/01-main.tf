resource "azurerm_route_table" "udr" {
  name                = "udr-${var.workload}-${var.environment}-${var.location}-001"
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_route" "jumpbox_to_firewall" {
  name                   = "jumpbox_to-firewall"
  resource_group_name    = var.rg_name
  route_table_name       = azurerm_route_table.udr.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ip
}

resource "azurerm_subnet_route_table_association" "rt_association" {
  subnet_id      = var.jumpbox_snet_id
  route_table_id = azurerm_route_table.udr.id
}