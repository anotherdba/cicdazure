terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57.0"
    }
  }


  backend "azurerm" {
    resource_group_name  = "backendRG"
    storage_account_name = "backendstoragemed"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {

 subscription_id = "36ae20ae-926b-47c3-9d23-378c40a29922"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


