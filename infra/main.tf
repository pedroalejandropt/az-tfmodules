terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.109.0"
    }
  }
  # TODO: Reference to the tfstate in Azure
}

provider "azurerm" {
  features {}

  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  subscription_id = var.ARM_SUPSCRIPTION_ID
  tenant_id       = var.ARM_TENANT_ID
}

module "boilerplate" {
  source = "./applications/boilerplate"
}