resource "azurerm_route_table" "route_table" {
  name                = "tr-${var.name}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  route               = var.routes
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.route_table.id
}