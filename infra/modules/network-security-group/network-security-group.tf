resource "azurerm_network_security_group" "nsg" {
  name                = "ngs-${var.name}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  security_rule       = var.security_rules
}

resource "azurerm_subnet_network_security_group_association" "nsg" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}