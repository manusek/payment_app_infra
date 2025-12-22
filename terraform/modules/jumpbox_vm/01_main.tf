resource "azurerm_network_interface" "nic" {
  name                = "nic-jumpbox-${var.workload}-${var.environment}-${var.location}-001"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.jumpbox_snet_id
    private_ip_address_allocation = "Dynamic"
  }
}