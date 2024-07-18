resource "azurerm_public_ip" "public_ip" {
  name                = var.name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  allocation_method   = var.allocation_method
  sku                 = var.sku
}