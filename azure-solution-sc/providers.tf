terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev"
    storage_account_name = "sttfstatedev001"
    container_name       = "tfstate"
    key                  = "landing-zone-dev.tfstate"
  }
}

provider "azurerm" {
  features {}
}
