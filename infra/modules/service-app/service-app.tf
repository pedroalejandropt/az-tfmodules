resource "azurerm_service_plan" "app_service_plan" {
  name                = var.name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}