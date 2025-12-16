output "rg_name" {
  value = azurerm_resource_group.rg_hub.name
}

output "rg_location" {
  value = azurerm_resource_group.rg_hub.location
}

output "snet_id" {
  value = azurerm_subnet.snet.id
}