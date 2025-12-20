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

variable "db_snet_id" {
  description = "ID of subnet where database is create"
  type = string
}

variable "db_private_dns_zone_id" {
  description = "ID of private dns zone attach to db"
  type = string
}

variable "db_private_link" {
  description = "ID of private link attach to db"
  type = string
}