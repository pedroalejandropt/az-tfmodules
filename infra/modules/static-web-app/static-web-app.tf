resource "azurerm_static_web_app" "static_site" {
  name                = var.name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size
}

resource "azurerm_static_web_app_custom_domain" "custom_domain" {
  for_each          = { for domain in var.custom_domains : domain.domain_name => domain }
  static_web_app_id = azurerm_static_web_app.static_site.id
  domain_name       = each.value.domain_name
  validation_type   = each.value.validation_type
}
