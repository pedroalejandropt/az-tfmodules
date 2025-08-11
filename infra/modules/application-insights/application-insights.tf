resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.name}-log-analytics-workspace"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
}

resource "azurerm_application_insights" "insights" {
  name                = "${var.name}-app-insights"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  workspace_id        = azurerm_log_analytics_workspace.log_analytics_workspace.id
  application_type    = var.application_type
}