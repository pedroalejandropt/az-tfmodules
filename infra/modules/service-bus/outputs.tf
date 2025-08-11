output "servicebus_namespace_id" {
  value = azurerm_servicebus_namespace.servicebus_namespace.id
}

output "servicebus_namespace_name" {
  value = azurerm_servicebus_namespace.servicebus_namespace.name
}

output "queue_ids" {
  value = { for k, queue in azurerm_servicebus_queue.servicebus_queue : k => queue.id }
}

output "queue_names" {
  value = { for k, queue in azurerm_servicebus_queue.servicebus_queue : k => queue.name }
}