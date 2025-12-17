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

variable "pep_snet_id" {
  description = "Id of subnet for private endpoints"
  type = string 
}

variable "acr_id" {
  description = "Id of acr for private enpoint"
  type = string
}