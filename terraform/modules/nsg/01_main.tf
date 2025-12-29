# DODAC SG DLA SUBNETOW AKS, DB, JUMPBOXA i bastion hosta


################
# SG FOR JUMPBOX
################

resource "azurerm_network_security_group" "nsg_jumpbox" {
  name                = "nsg-jumpbox-${var.workload}-${var.environment}-${var.location}-001"
  location            = var.location
  resource_group_name = var.rg_name

  # SSH only from bastion 
  security_rule {
    name                       = "Allow-SSH-from-Bastion"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "10.2.0.64/26"         # ruch tylko z podsieci dla bastion hosta
    source_port_range          = "*"                    # port w podsieci bastoin z ktorego idzie ruch
    destination_address_prefix = "10.0.11.0/27"         # adres na ktory przychodzi ruch z bastion (adres podsieci dla vm)
    destination_port_range     = "22"                   # port na VM do ktorego kierowany jest ruch z bastion
  }

  # outbound traffic only to db
  security_rule {
    name                       = "Allow-Postgres-Out"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "10.0.11.0/27"
    source_port_range          = "*"                # port vm z ktorego ruch idzie do db
    destination_address_prefix = "10.0.10.0/24"     # adres do ktorego idzie ruch vm
    destination_port_range     = "5432"             # port do ktorego idzie ruch z vm
  }

  # outbound traffic to 
  security_rule {
    name                       = "Allow-Outbound-Package-Installation-HTTP"
    priority                   = 150 
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp" 
    source_address_prefix      = "10.0.11.0/27" 
    source_port_range          = "*"
    destination_address_prefix = "0.0.0.0/0" # Tag uslugi dla calego internetu
    destination_port_range     = "80" 
  }

  security_rule {
    name                       = "Allow-Outbound-Package-Installation-HTTPS"
    priority                   = 151 
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp" 
    source_address_prefix      = "10.0.11.0/27" 
    source_port_range          = "*"
    destination_address_prefix = "0.0.0.0/0" 
    destination_port_range     = "443" 
  }
}


resource "azurerm_subnet_network_security_group_association" "jumpbox" {
  subnet_id                 = var.jumpbox_snet_id
  network_security_group_id = azurerm_network_security_group.nsg_jumpbox.id

  depends_on = [azurerm_network_security_group.nsg_jumpbox]
}