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

variable "vnet_cidr" {
  description = "CIDR of hub vnet"
  type = string
  default = "10.2.0.0/21"
}

variable "snet_cidr_firewall" {
  description = "CIDR of firewall snet"
  type = string
  default = "10.2.0.0/26"
}

variable "snet_cidr_bastion" {
  description = "CIDR of firewall snet"
  type = string
  default = "10.2.0.64/26"
}