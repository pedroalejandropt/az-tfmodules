resource "azurerm_linux_function_app" "function_app" {
  name                       = var.name
  location                   = var.resource_group.location
  resource_group_name        = var.resource_group.name
  service_plan_id            = var.app_service_plan_id
  storage_account_name       = var.storage_account.name
  storage_account_access_key = var.storage_account.primary_access_key
  virtual_network_subnet_id  = var.virtual_network_subnet_id

  site_config {
    always_on                              = lookup(var.site_config, "always_on", null)
    http2_enabled                          = lookup(var.site_config, "http2_enabled", null)
    app_command_line                       = lookup(var.site_config, "app_command_line", null)
    ftps_state                             = lookup(var.site_config, "ftps_state", null)
    linux_fx_version                       = lookup(var.site_config, "linux_fx_version", null)
    application_insights_key               = lookup(var.site_config, "application_insights_key", null)
    application_insights_connection_string = lookup(var.site_config, "application_insights_connection_string", null)

    dynamic "application_stack" {
      for_each = lookup(var.site_config, "application_stack", null) != null ? [lookup(var.site_config, "application_stack", null)] : []

      content {
        node_version   = lookup(application_stack.value, "node_version", null)
        python_version = lookup(application_stack.value, "python_version", null)
      }
    }

    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        action      = ip_restriction.value.action
        headers     = ip_restriction.value.headers
        name        = ip_restriction.value.name
        priority    = ip_restriction.value.priority
        service_tag = ip_restriction.value.service_tag
      }
    }

    dynamic "cors" {
      for_each = length(var.allowed_origins) > 0 ? [1] : []
      content {
        allowed_origins = var.allowed_origins
      }
    }
  }

  lifecycle {
    ignore_changes = [
      site_config[0].http2_enabled,
      site_config[0].app_command_line,
      site_config[0].ftps_state,
      site_config[0].ip_restriction,
      site_config[0].cors,
      app_settings,
      site_config[0].application_stack[0].docker,
      site_config[0].linux_fx_version
    ]
  }
}