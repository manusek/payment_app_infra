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

######## SPOKE VNET

variable "rg_spoke_name" {
  description = "Name of rg where hub vnet exist"
  type = string
}

variable "vnet_spoke_name" {
  description = "Name of spoke vnet"
  type = string
}

variable "vnet_spoke_id" {
  description = "ID of spoke vnet"
  type = string
}


######## HUB VNET

variable "rg_hub_name" {
  description = "Name of rg where spoke vnet exist"
  type = string
}

variable "vnet_hub_name" {
  description = "Name of hub vnet"
  type = string
}

variable "vnet_hub_id" {
  description = "ID of hub vnet"
  type = string
}
