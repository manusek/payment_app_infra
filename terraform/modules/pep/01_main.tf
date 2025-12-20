resource "azurerm_private_endpoint" "acr_pep" {
  name                = "pep-acr-${var.workload}-${var.environment}-${var.location}-001"
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

resource "azurerm_private_endpoint" "kv_pep" {
  name                = "pep-kv-${var.workload}-${var.environment}-${var.location}-002"
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = var.pep_snet_id

  private_service_connection {
    name                           = "kv-connection"
    private_connection_resource_id = var.kv_id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}