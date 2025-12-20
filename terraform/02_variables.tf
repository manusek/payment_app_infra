variable "workload" {
  description = "Name of workload"
  type        = string
}

variable "environment" {
  description = "Type of enviromet"
  type        = string
}

variable "location" {
  description = "Resource location"
  type        = string
  default     = "polandcentral"
}