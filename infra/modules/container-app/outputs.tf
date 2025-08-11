output "name" {
  value = azurerm_container_app.container_app.name
}

output "id" {
  value = azurerm_container_app.container_app.id
}

output "fqdn" {
  value = azurerm_container_app.container_app.latest_revision_fqdn
}