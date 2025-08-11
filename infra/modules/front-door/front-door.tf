resource "azurerm_cdn_frontdoor_profile" "cdn_frontdoor_profile" {
  name                = var.frontdoor_profile_name
  resource_group_name = var.config.resource_group_name
  sku_name            = var.config.frontdoor_sku_name
}

resource "azurerm_cdn_frontdoor_endpoint" "cdn_frontdoor_endpoint" {
  name                     = var.frontdoor_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id
}

resource "azurerm_cdn_frontdoor_origin_group" "cdn_frontdoor_origin_group" {
  for_each                 = { for each in var.backend_pools : each.name => each }
  name                     = "frog-${var.config.env}-${each.value.name}"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10

  health_probe {
    interval_in_seconds = 240
    path                = "/"
    protocol            = "Http"
    request_type        = "GET"
  }

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 4
    successful_samples_required        = 2
  }
}

resource "azurerm_cdn_frontdoor_origin" "cdn_frontdoor_origin" {
  for_each                      = { for each in var.backend_pools : each.name => each }
  name                          = each.value.name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group[each.value.name].id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name          = each.value.host_name
  http_port          = each.value.http_port
  https_port         = each.value.https_port
  origin_host_header = try(each.value.origin_host_header, each.value.host_name)
  priority           = 1
  weight             = 1
}

resource "azurerm_cdn_frontdoor_route" "cdn_frontdoor_route" {
  for_each                      = { for each in var.routing_rules : each.name => each }
  name                          = each.value.name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_frontdoor_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group[each.value.backend_pool_name].id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.cdn_frontdoor_origin[each.value.backend_pool_name].id]
  enabled                       = true

  forwarding_protocol    = each.value.forwarding_protocol
  https_redirect_enabled = true
  patterns_to_match      = each.value.patterns_to_match
  supported_protocols    = each.value.accepted_protocols

  cdn_frontdoor_custom_domain_ids = [
    for domain_name in each.value.associated_domains :
    azurerm_cdn_frontdoor_custom_domain.cdn_custom_domain[domain_name].id
  ]

  dynamic "cache" {
    for_each = var.cache.enabled ? [1] : []
    content {
      query_string_caching_behavior = var.cache.behavior
      compression_enabled           = var.cache.compression
      content_types_to_compress     = var.cache.content_types
    }
  }

  lifecycle {
    ignore_changes = [cdn_frontdoor_rule_set_ids]
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "cdn_custom_domain" {
  for_each                 = { for each in var.custom_domains : each.name => each }
  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id
  host_name                = each.value.host_name

  tls {
    certificate_type    = each.value.certificate_type
    minimum_tls_version = each.value.minimum_tls_version
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "cdn_custom_domain_association" {
  for_each                       = { for each in var.custom_domains : each.name => each }
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.cdn_custom_domain[each.key].id
  cdn_frontdoor_route_ids        = [for route in each.value.route_names : azurerm_cdn_frontdoor_route.cdn_frontdoor_route[route].id]
}
