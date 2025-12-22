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

variable "snet_bastion_id" {
  description = "ID of subnet where bastion host is created"
  type = string
}