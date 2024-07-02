module "boilerplate_resource_group" {
  source   = "../modules/resource-group"
  name     = "boilerplate-west-resource-group"
  location = "West Europe"
}

module "boilerplate_storage_account" {
  source                  = "../modules/storage/account"
  resource_group_name     = module.boilerplate_resource_group.name
  resource_group_location = module.boilerplate_resource_group.location
  name                    = "boilerplatestgaccount"
  tier                    = "Standard"
  replication_type        = "LRS"
}

module "boilerplate_storage_container" {
  source               = "../modules/storage/container"
  name                 = "boilerplate-stg-blob-tfstate"
  storage_account_name = module.boilerplate_storage_account.name
  access_type          = "blob"
}

module "boilerplate_vnet" {
  source                  = "../modules/virtual-network"
  resource_group_name     = module.boilerplate_resource_group.name
  resource_group_location = module.boilerplate_resource_group.location
  name                    = "boilerplate-vnet"
  address_space = [
    "10.245.12.0/22",
    "10.245.16.0/22"
  ]
}

module "boilerplate_subnet" {
  source              = "../modules/subnet"
  name                = "test-subnet"
  address_prefix      = ["10.245.16.0/22"]
  vnet_name           = module.boilerplate_vnet.name
  resource_group_name = module.boilerplate_resource_group.name
}

module "boilerplate_container_registry" {
  source                  = "../modules/container-registry"
  name                    = "boilerplateACR"
  resource_group_location = module.boilerplate_resource_group.location
  resource_group_name     = module.boilerplate_resource_group.name
  sku                     = "Basic"
}

module "boilerplate_k8_cluster" {
  source                    = "../modules/kubernetes"
  name                      = "boilerplate-cluster"
  resource_group_location   = module.boilerplate_resource_group.location
  resource_group_name       = module.boilerplate_resource_group.name
  dns_prefix                = "aks"
  automatic_channel_upgrade = "patch"

  // TODO: create as a object variable node_pool
  node_name           = "testnode"
  node_count          = 1
  node_min_count      = 1
  node_max_count      = 2
  node_vm_size        = "Standard_D8s_v4"
  enable_auto_scaling = true
  subnet_id           = module.boilerplate_subnet.id
  availability_zones  = [3]
  //END

  // TODO: create as a object variable network_profile
  service_cidr   = "10.245.14.0/23"
  dns_service_ip = "10.245.14.10"
  // END

  role_name             = "AcrPull"
  container_registry_id = module.boilerplate_container_registry.id
  ad_name               = "boilerplate"
}