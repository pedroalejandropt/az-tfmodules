resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "az-func-${var.name}-service-plan"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  kind                = var.app_service_plan.kind
  reserved            = var.app_service_plan.reserved

  sku {
    tier = var.sku.tier
    size = var.sku.size
  }
}

resource "azurerm_function_app" "function_app" {
  name                       = var.name
  location                   = var.resource_group.location
  resource_group_name        = var.resource_group.name
  app_service_plan_id        = azurerm_app_service_plan.app_service_plan.id
  storage_account_name       = var.storage_account.name
  storage_account_access_key = var.storage_account.primary_access_key
  os_type                    = var.os_type
  version                    = var.func_version
}