provider "azurerm" {
  features {}
  subscription_id = "84ee9c1b-169c-4414-9364-22c63cf65d2a"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
