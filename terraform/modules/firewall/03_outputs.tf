output "firewall_private_ip" {
  value = azurerm_firewall.afw.ip_configuration[0].private_ip_address
}