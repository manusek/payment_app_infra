module "hub-network" {
  source = "./modules/network/vnet-hub"

  workload    = var.workload
  environment = var.environment
  location    = var.location
}

module "spoke-network" {
  source = "./modules/network/vnet-spoke"

  workload    = var.workload
  environment = var.environment
  location    = var.location
}

module "hub-firewall" {
  source = "./modules/firewall"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_name     = module.hub-network.rg_name
  rg_location = module.hub-network.rg_location
  snet_id     = module.hub-network.snet_id
}

module "vnet_peering" {
  source = "./modules/network/vnet_peering"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_spoke_name   = module.spoke-network.rg_name
  vnet_spoke_name = module.spoke-network.spoke_vnet_name
  vnet_spoke_id   = module.spoke-network.spoke_vnet_id

  rg_hub_name   = module.hub-network.rg_name
  vnet_hub_name = module.hub-network.hub_vnet_name
  vnet_hub_id   = module.hub-network.hub_vnet_id
}

module "acr" {
  source = "./modules/acr"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_name     = module.spoke-network.rg_name
  rg_location = module.spoke-network.rg_location
}

module "pep" {
  source = "./modules/pep"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_name     = module.spoke-network.rg_name
  rg_location = module.spoke-network.rg_location

  acr_id = module.acr.acr_id

  pep_snet_id = module.spoke-network.pep_snet_id
}

module "private_dns_zone" {
  source = "./modules/private_dns_zone"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_name        = module.spoke-network.rg_name
  spoke_vnet_id  = module.spoke-network.spoke_vnet_id
  acr_name       = module.acr.acr_name
  pep_private_ip = module.pep.pep_private_ip
}

module "kv" {
  source = "./modules/kv"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_location = module.spoke-network.rg_location
  rg_name     = module.spoke-network.rg_name
}
