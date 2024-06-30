resource "azurerm_virtual_network" "virtual_network" {
  name                = var.name
  address_space       = [var.address_space]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}