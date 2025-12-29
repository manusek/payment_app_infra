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

variable "jumpbox_snet_id" {
  description = "Id of subnet where jumpbox vm is configured"
  type = string
}

variable "firewall_private_ip" {
  description = "Firewall private ip to use as next_hop in UDR"
  type = string
}