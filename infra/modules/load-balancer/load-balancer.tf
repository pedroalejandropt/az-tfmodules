resource "azurerm_lb" "load_balancer" {
  name                = var.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  dynamic "frontend_ip_configuration" {
    for_each = var.public_ip_list

    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = frontend_ip_configuration.value.id
    }
  }
}