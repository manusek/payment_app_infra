output "rg_name" {
  value = azurerm_resource_group.rg_hub.name
}

output "rg_location" {
  value = azurerm_resource_group.rg_hub.location
}

output "snet_id" {
  value = azurerm_subnet.snet.id
}

output "snet_bastion_id" {
  value = azurerm_subnet.snet_bastion.id
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.vnet_hub.name
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.vnet_hub.id
}