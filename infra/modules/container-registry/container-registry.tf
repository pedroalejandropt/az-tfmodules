resource "azurerm_container_registry" "container_registry" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = var.sku
  admin_enabled       = false
}