resource "azurerm_search_service" "search_service" {
  name                = var.name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  sku                 = var.sku
}