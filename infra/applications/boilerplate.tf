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
  // address_space           = "10.0.0.0/16"
}

module "boilerplate_subnet" {
  source = "../modules/subnet"
  name   = "test-subnet"
  // address_prefix      = "10.0.1.0/24"
  vnet_name           = module.boilerplate_vnet.name
  resource_group_name = module.boilerplate_resource_group.name
}

/* module "boilerplate_public_ip_dormakaba" {
  source                  = "../modules/public-ip"
  name                    = "public-ip-dormakaba"
  resource_group_name     = module.boilerplate_resource_group.name
  resource_group_location = module.boilerplate_resource_group.location
}

module "boilerplate_public_ip_unknown" {
  source                  = "../modules/public-ip"
  name                    = "public-ip-unknown"
  resource_group_name     = module.boilerplate_resource_group.name
  resource_group_location = module.boilerplate_resource_group.location
}

module "boilerplate_lb" {
  source                  = "../modules/load-balancer"
  name                    = "boilerplate-lb"
  resource_group_location = module.boilerplate_resource_group.location
  resource_group_name     = module.boilerplate_resource_group.name
  sku                     = "Standard"
  public_ip_list = [
    { name = module.boilerplate_public_ip_dormakaba.name, id = module.boilerplate_public_ip_dormakaba.id },
    { name = module.boilerplate_public_ip_unknown.name, id = module.boilerplate_public_ip_unknown.id }
  ]
} */

module "boilerplate_container_registry" {
  source                  = "../modules/container-registry"
  name                    = "boilerplateACR"
  resource_group_location = module.boilerplate_resource_group.location
  resource_group_name     = module.boilerplate_resource_group.name
  sku                     = "Basic"
}

module "boilerplate_k8_cluster" {
  source                  = "../modules/kubernetes"
  name                    = "boilerplate-cluster"
  resource_group_location = module.boilerplate_resource_group.location
  resource_group_name     = module.boilerplate_resource_group.name
  dns_prefix              = "aks"
  node_name               = "testnode"
  availability_zones      = [3]
  enable_auto_scaling     = true
  node_count              = 1
  node_min_count          = 1
  node_max_count          = 2
  node_vm_size            = "Standard_D8s_v4"
  subnet_id               = module.boilerplate_subnet.id

  role_name             = "AcrPull"
  container_registry_id = module.boilerplate_container_registry.id
  ad_name               = "boilerplate"
}