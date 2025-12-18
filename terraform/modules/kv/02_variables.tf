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

#api

# APP_ENV=dev
# PAYMENT_DB_URL=jdbc:postgresql://payments-db:5432/payments
# PAYMENT_DB_USER=payments
# PAYMENT_DB_PASSWORD=payments
# PAYMENT_WORKER_BASE_URL=http://payment-worker:8090
# LOG_LEVEL=INFO


# worker 

# PAYMENT_WORKER_PORT=8090
# PAYMENT_API_BASE_URL=http://payment-api:8080
# WORKER_CPU_LOAD_MS=300