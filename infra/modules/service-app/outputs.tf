output "id" {
  description = "The ID of the service plan"
  value       = azurerm_service_plan.app_service_plan.id
}

output "name" {
  description = "The name of the service plan"
  value       = azurerm_service_plan.app_service_plan.name
}