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

variable "acr_name" {
  description = "Name of acr for private enpoint"
  type = string
}

variable "kv_name" {
  description = "Name of kv for private endpoint"
  type = string
}

variable "spoke_vnet_id" {
  description = "ID of vnet for DNS zone"
  type = string
}

variable "acr_pep_private_ip" {
  description = "ACR private endpoint ip for dns zone"
  type = string
}

variable "kv_pep_private_ip" {
  description = "Key Vault private endpoint ip for dns zone"
  type = string
}

variable "db_snet_id" {
  description = "Subnet where database is"
}