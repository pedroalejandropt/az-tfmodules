output "search_service_id" {
  value = azurerm_search_service.search_service.id
}

output "search_service_name" {
  value = azurerm_search_service.search_service.name
}

output "search_service_url" {
  value = azurerm_search_service.search_service.query_keys[0].key
}