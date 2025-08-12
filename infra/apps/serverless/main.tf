

module "serverless_storage_account" {
  source = "../../modules/storage/account"
  name   = "${var.name}stgaccount"

  resource_group = {
    name     = var.resource_group.name
    location = var.resource_group.location
  }

  tier             = "Standard"
  replication_type = "LRS"
}

module "serverless_service_app" {
  source = "../../modules/service-app"
  name   = "${var.name}-${var.env}-service-app"

  resource_group = {
    name     = var.resource_group.name
    location = var.resource_group.location
  }

  os_type  = "Linux"
  sku_name = "P0v3"
}

module "serverless_backend" {
  source = "../../modules/function"
  name   = "${var.name}-${var.env}-backend"
  app_service_plan_id = module.serverless_service_app.id

  site_config = {
    application_stack = {
      node_version = "20"
    }
  }

  resource_group = {
    name     = var.resource_group.name
    location = var.resource_group.location
  }

  storage_account = {
    name               = module.serverless_storage_account.name
    primary_access_key = module.serverless_storage_account.primary_access_key
  }
}
