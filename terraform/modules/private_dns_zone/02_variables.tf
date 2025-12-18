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

variable "spoke_vnet_id" {
  description = "ID of vnet for DNS zone"
  type = string
}

variable "pep_private_ip" {
  description = "Private endpoint ip for dns zone"
  type = string
}
