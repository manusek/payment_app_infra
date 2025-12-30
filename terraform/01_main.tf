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

    depends_on = [
    module.aks,
    module.spoke-network
  ]
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
  kv_id  = module.kv.kv_id

  pep_snet_id = module.spoke-network.pep_snet_id
}

module "private_dns_zone" {
  source = "./modules/private_dns_zone"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_name       = module.spoke-network.rg_name
  spoke_vnet_id = module.spoke-network.spoke_vnet_id

  acr_name           = module.acr.acr_name
  acr_pep_private_ip = module.pep.acr_pep_private_ip

  kv_name           = module.kv.kv_name
  kv_pep_private_ip = module.pep.kv_pep_private_ip

  db_snet_id = module.spoke-network.db_snet_id
}

module "kv" {
  source = "./modules/kv"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_location = module.spoke-network.rg_location
  rg_name     = module.spoke-network.rg_name
}

module "database" {
  source = "./modules/database"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_location = module.spoke-network.rg_location
  rg_name     = module.spoke-network.rg_name

  db_private_link        = module.private_dns_zone.db_private_link_id
  db_snet_id             = module.spoke-network.db_snet_id
  db_private_dns_zone_id = module.private_dns_zone.db_private_dns_zone_id
}

module "bastion_host" {
  source = "./modules/bastion_host"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_name         = module.hub-network.rg_name
  rg_location     = module.hub-network.rg_location
  snet_bastion_id = module.hub-network.snet_bastion_id
}

module "jumpbox_vm" {
  source = "./modules/jumpbox_vm"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_name = module.spoke-network.rg_name
  rg_location = module.spoke-network.rg_location
  jumpbox_snet_id = module.spoke-network.jumpbox_snet_id
}

module "nsg" {
  source = "./modules/nsg"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_name = module.spoke-network.rg_name
  rg_location = module.spoke-network.rg_location
  jumpbox_snet_id = module.spoke-network.jumpbox_snet_id
}

# module "udr" {
#   source = "./modules/udr"

#   workload    = var.workload
#   environment = var.environment
#   location    = var.location

#   rg_name = module.spoke-network.rg_name
#   rg_location = module.spoke-network.rg_location
#   jumpbox_snet_id = module.spoke-network.jumpbox_snet_id
#   firewall_private_ip = module.hub-firewall.firewall_private_ip
# }

module "admin" {
  source = "./modules/admins"
}

module "aks" {
  source = "./modules/aks"

  workload    = var.workload
  environment = var.environment
  location    = var.location

  rg_name = module.spoke-network.rg_name
  rg_location = module.spoke-network.rg_location
  spoke_vnet_id = module.spoke-network.spoke_vnet_id
  aks_subnet_id = module.spoke-network.aks_subnet_id
  acr_id = module.acr.acr_id
  aks_rbac_admin_group_object_id = module.admin.admin_group_id
}

module "ingress_nginx" {
  source = "./modules/nginx_ingress_controller"
  
  workload    = var.workload
  environment = var.environment
  location    = var.location

  aks_cluster_id = module.aks.aks_cluster_id
}
