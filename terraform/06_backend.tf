terraform {

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate9hcsm"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

}
