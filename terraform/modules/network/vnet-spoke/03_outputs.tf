output "rg_name" {
  value = azurerm_resource_group.rg_spoke.name
}

output "rg_location" {
  value = azurerm_resource_group.rg_spoke.location
}

output "spoke_vnet_name" {
  value = azurerm_virtual_network.vnet_spoke.name
}

output "spoke_vnet_id" {
  value = azurerm_virtual_network.vnet_spoke.id
}

output "pep_snet_id" {
  value = azurerm_subnet.snet2.id
}