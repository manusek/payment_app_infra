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

