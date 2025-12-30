variable "workload" {
  description = "Name of workload"
  type = string
}

variable "environment" {
  description = "Type of enviromet"
  type = string
}

variable "location" {
  description = "Resource location"
  type = string
}

variable "rg_name" {
  description = "Name of rg"
  type = string
}

variable "rg_location" {
  description = "Location of rg"
  type = string
}

variable "acr_id" {
  description = "Id of ACR with images"
  type = string
}

variable "aks_subnet_id" {
  description = "Id of AKS subnet"
  type = string
}

variable "aks_rbac_admin_group_object_id" {
  type        = string
  description = "value of the AKS administrators group object id in Azure Active Directory"
}

variable "spoke_vnet_id" {
  description = "Id of spoke vnet"
  type = string
}