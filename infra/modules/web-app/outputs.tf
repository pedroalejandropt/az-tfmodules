output "name" {
  description = "Web App name"
  value       = var.name
}

output "url" {
  description = "Web app URL"
  value = var.os_type == "Linux" ? (
    azurerm_linux_web_app.webapp_linux[0].default_hostname
    ) : (
    azurerm_windows_web_app.webapp_windows[0].default_hostname
  )
}
