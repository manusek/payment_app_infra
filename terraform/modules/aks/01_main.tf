
locals {
  # Wyodrebnia UUID z dowolnego ciagu znakow
  group_uuid_clean = regex("([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})", var.aks_rbac_admin_group_object_id)[0]
}


######
# AKS
######

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.workload}-${var.environment}-${var.location}-001"
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix          = "aks-payments"
  node_resource_group = "rg-aks-paymentapp-dev"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D4s_v3"
    vnet_subnet_id = var.aks_subnet_id
  }

  local_account_disabled    = true
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  # integracja aks z entra id
  azure_active_directory_role_based_access_control {
    admin_group_object_ids = [local.group_uuid_clean]
    # zarzadzanie dostępem wewnatrz klastra odbywa sie przez kubernetes rbac zamiast roli azure
    # Entra ID służy tylko do logowania, a faktyczne uprawnienia w klastrze definiujesz samodzielnie za pomocą Kubernetes RBAC(role i role binding), zamiast wbudowanych ról Azure.
    # w azure definiuje sie grupy i kto do niej nalezy, jakie uprawnienia ma dana grupa definiuje sie w kubernetes przez role i role binding
    azure_rbac_enabled = false
  }

  network_profile {
    network_plugin   = "kubenet"
    pod_cidr           = "10.1.0.0/16" 
    service_cidr       = "10.2.0.0/24" 
    dns_service_ip     = "10.2.0.10" 
  }

  identity {
    type = "SystemAssigned"
  }
}


###########
# AKS ROLES
###########

# uprawnienie dla aks (kubelet) do pobierania obrazow z acr
resource "azurerm_role_assignment" "acrpull_role" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
}

# uprawnienie dla aks (control plane) do tworzenia zasobow w podsieci
resource "azurerm_role_assignment" "network_role" {
  scope                = var.aks_subnet_id
  role_definition_name = "Network Contributor"
  # id tozsamosci aks w entra id, czyli managed identity przypisana do klastra aks
  principal_id         = azurerm_kubernetes_cluster.aks.identity.0.principal_id
}