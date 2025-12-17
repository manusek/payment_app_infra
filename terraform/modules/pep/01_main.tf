resource "azurerm_private_endpoint" "acr_pep" {
  name                = "pep-${var.workload}-${var.environment}-${var.location}-001"
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = var.pep_snet_id

  private_service_connection {
    name                           = "acr-connection"
    private_connection_resource_id = var.acr_id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }
}