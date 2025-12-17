resource "azurerm_container_registry" "acr" {
  name                = "acr${var.workload}${var.environment}${var.location}001"
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = "Premium"       # wymagane przez private endpoint
}