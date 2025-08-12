module "project_resource_group" {
  source   = "../../modules/resource-group"
  name     = "dev-project-we-rg"
  location = "West Europe"
}

module "serverless" {
  source = "../../apps/serverless"
  env    = "dev"
  name = "app"
  resource_group = {
    name     = module.project_resource_group.name
    location = module.project_resource_group.location
  }
}