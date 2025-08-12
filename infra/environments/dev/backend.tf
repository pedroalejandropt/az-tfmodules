terraform {
  ## empty backed to get configuration from hcl files
  # backend "azurerm" {}

  ## explicit configutation
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = ""
  }
}