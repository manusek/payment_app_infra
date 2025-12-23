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
  description = "CIDR of spoke vnet"
  type = string
  default = "10.0.0.0/20"
}

variable "snet_cidr_aks" {
  description = "CIDR of AKS snet"
  type = string
  default = "10.0.0.0/21"
}

variable "snet_cidr_endpoints" {
  description = "CIDR of endpoints snet"
  type = string
  default = "10.0.8.0/23"
}

variable "snet_cidr_db" {
  description = "CIDR of DB snet"
  type = string
  default = "10.0.10.0/24"
}

variable "snet_cidr_jumpbox" {
  description = "CIDR of jumpbox snet"
  type = string
  default = "10.0.11.0/27"
}