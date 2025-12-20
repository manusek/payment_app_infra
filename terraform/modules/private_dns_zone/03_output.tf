output "db_private_dns_zone_id" {
  value = azurerm_private_dns_zone.db_private_dns_zone.id
}

output "db_private_link_id" {
  value = azurerm_private_dns_zone_virtual_network_link.vnet_link_db.id
}