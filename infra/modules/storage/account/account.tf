resource "azurerm_storage_account" "storage_account" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = var.tier
  account_replication_type = var.replication_type

  /* tags = {
    environment = "staging"
  } */
}