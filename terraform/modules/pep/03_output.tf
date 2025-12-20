output "acr_pep_private_ip" {
  value = azurerm_private_endpoint.acr_pep.private_service_connection[0].private_ip_address
}

output "kv_pep_private_ip" {
  value = azurerm_private_endpoint.kv_pep.private_service_connection[0].private_ip_address
}