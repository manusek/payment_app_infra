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
  default = "10.0.0.0/22"
}


variable "snet_cidr" {
  description = "CIDR of firewall snet"
  type = string
  default = "10.0.0.0/24"
}