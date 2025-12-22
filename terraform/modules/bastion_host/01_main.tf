resource "azurerm_public_ip" "pip_bastion" {
   name               = "pip-bastion-${var.workload}-${var.environment}-${var.location}-002"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bas" {
  name                = "bas-${var.workload}-${var.environment}-${var.location}-002"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = "bastion_configuration"
    subnet_id            = var.snet_bastion_id
    public_ip_address_id = azurerm_public_ip.pip_bastion.id
  }
}