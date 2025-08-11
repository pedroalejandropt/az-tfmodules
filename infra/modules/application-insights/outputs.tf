output "instrumentation_key" {
  value     = azurerm_application_insights.insights.instrumentation_key
  sensitive = true
}

output "connection_string" {
  value     = azurerm_application_insights.insights.connection_string
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.insights.app_id
}