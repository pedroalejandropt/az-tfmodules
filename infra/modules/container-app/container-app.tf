resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.name}-log-workspace"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  sku                 = var.log_workspace.sku
  retention_in_days   = var.log_workspace.retention_in_days
}

resource "azurerm_container_app_environment" "container_app_environment" {
  name                       = "${var.name}-env"
  location                   = var.resource_group.location
  resource_group_name        = var.resource_group.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

resource "azurerm_container_app" "container_app" {
  name                         = "${var.name}-app"
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = var.resource_group.name
  revision_mode                = var.container_app.revision_mode

  ingress {
    target_port      = var.ingress.target_port
    external_enabled = var.ingress.external_enabled
    traffic_weight {
      percentage      = var.ingress.traffic_weight_percentage
      latest_revision = var.ingress.latest_revision
    }
  }

  secret {
    name  = var.container_app.secret_name
    value = var.container_app.secret_value
  }

  registry {
    server               = var.registry.server
    username             = var.registry.username
    password_secret_name = var.container_app.secret_name
  }

  template {
    # sample container image (mandatory property)
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  lifecycle {
    ignore_changes = [
      template,
      registry
    ]
  }
}