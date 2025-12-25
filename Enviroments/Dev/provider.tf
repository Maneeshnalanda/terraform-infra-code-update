terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "maneesh22"
    storage_account_name = "maneeshstorage01"
    container_name       = "maneeshcontainer"
    key                  = "mk.tfstate"

  }
}

provider "azurerm" {
  features {}
  subscription_id = "009fad33-c09c-4841-af38-57dd79870d40"
}








