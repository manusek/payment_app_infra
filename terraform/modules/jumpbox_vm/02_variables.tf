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

variable "home" {
  description = "Home path to public ssh key"
  type    = string
  default = "/Users/kdlugosz"
}