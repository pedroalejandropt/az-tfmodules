resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                = "${var.name}-namespace"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  sku                 = var.sku
}

resource "azurerm_servicebus_queue" "servicebus_queue" {
  for_each     = toset(var.queue_list)
  name         = each.key
  namespace_id = azurerm_servicebus_namespace.servicebus_namespace.id
}