output "id" {
  value = azurerm_public_ip.public_ip.id
}

output "name" {
  value = azurerm_public_ip.public_ip.name
}

output "outbound_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}