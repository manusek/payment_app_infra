output "pep_private_ip" {
  value = azurerm_private_endpoint.acr_pep.private_service_connection[0].private_ip_address
}