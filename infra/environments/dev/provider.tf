terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.109.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  ## explicit provider login
  # client_id       = var.ARM_CLIENT_ID
  # client_secret   = var.ARM_CLIENT_SECRET
  # subscription_id = var.ARM_SUPSCRIPTION_ID
  # tenant_id       = var.ARM_TENANT_ID
}