terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.56"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~>2.12.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.0"
    }
  }
}