resource "azurerm_linux_web_app" "webapp_linux" {
  count               = var.os_type == "Linux" ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  service_plan_id     = var.app_service_plan_id

  site_config {
    always_on        = var.always_on
    app_command_line = var.app_command_line

    application_stack {
      node_version      = var.node_version
      docker_image_name = var.docker_image.name != null ? "${var.docker_image.name}:${var.docker_image.tag}" : null
    }
  }

  app_settings = merge(
    var.app_settings,
    {
      WEBSITE_NODE_DEFAULT_VERSION = var.node_version
    }
  )

  lifecycle {
    ignore_changes = [app_settings, site_config]
  }
}

resource "azurerm_windows_web_app" "webapp_windows" {
  count               = var.os_type == "Windows" ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  service_plan_id     = var.app_service_plan_id

  site_config {
    always_on        = var.always_on
    app_command_line = var.app_command_line

    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = merge(
    var.app_settings,
    {
      WEBSITE_NODE_DEFAULT_VERSION = var.node_version
    }
  )

  lifecycle {
    ignore_changes = [app_settings, site_config]
  }
}