output "id" {
  value     = azurerm_container_registry.container_registry.id
  sensitive = true
}

output "login_server" {
  value = azurerm_container_registry.container_registry.login_server
}

output "admin_username" {
  value = azurerm_container_registry.container_registry.admin_username
}

output "admin_password" {
  value = azurerm_container_registry.container_registry.admin_password
}
