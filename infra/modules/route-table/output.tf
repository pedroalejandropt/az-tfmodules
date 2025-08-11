output "id" {
  description = "The ID of the route table."
  value       = azurerm_route_table.route_table.id
}

output "name" {
  description = "The name of the route table."
  value       = azurerm_route_table.route_table.name
}

output "subnet_route_table_association_id" {
  description = "The ID of the subnet route table association."
  value       = azurerm_subnet_route_table_association.subnet_route_table_association.id
}