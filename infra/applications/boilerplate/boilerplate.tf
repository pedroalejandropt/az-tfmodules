module "boilerplate_resource_group" {
  source   = "../../modules/resource-group"
  name     = "boilerplate-west-resource-group"
  location = "West Europe"
}

module "boilerplate_storage_account" {
  source = "../../modules/storage/account"
  name   = "boilerplatestgaccount"

  resource_group = {
    name     = module.boilerplate_resource_group.name
    location = module.boilerplate_resource_group.location
  }

  tier             = "Standard"
  replication_type = "LRS"
}

module "boilerplate_az_function" {
  source = "../../modules/function"
  name   = "boilerplate-test-function"

  resource_group = {
    name     = module.boilerplate_resource_group.name
    location = module.boilerplate_resource_group.location
  }

  storage_account = {
    name               = module.boilerplate_storage_account.name
    primary_access_key = module.boilerplate_storage_account.primary_access_key
  }
}

module "boilerplate_storage_container" {
  source               = "../../modules/storage/container"
  name                 = "boilerplate-stg-blob-tfstate"
  storage_account_name = module.boilerplate_storage_account.name
  access_type          = "blob"
}

module "boilerplate_vnet" {
  source = "../../modules/virtual-network"
  name   = "boilerplate-vnet"

  resource_group = {
    name     = module.boilerplate_resource_group.name
    location = module.boilerplate_resource_group.location
  }

  address_space = [
    "10.245.12.0/22",
    "10.245.16.0/22"
  ]
}

module "boilerplate_subnet" {
  source              = "../../modules/subnet"
  name                = "test-subnet"
  address_prefix      = ["10.245.16.0/22"]
  vnet_name           = module.boilerplate_vnet.name
  resource_group_name = module.boilerplate_resource_group.name
}

module "boilerplate_container_registry" {
  source = "../../modules/container-registry"
  name   = "boilerplateACR"
  sku    = "Basic"

  resource_group = {
    name     = module.boilerplate_resource_group.name
    location = module.boilerplate_resource_group.location
  }
}

module "boilerplate_k8_cluster" {
  source = "../../modules/kubernetes"
  name   = "boilerplate-cluster"

  resource_group = {
    name     = module.boilerplate_resource_group.name
    location = module.boilerplate_resource_group.location
  }

  dns_prefix                = "aks"
  automatic_channel_upgrade = "patch"

  node_pool = {
    name                = "testnode"
    count               = 1
    min_count           = 1
    max_count           = 2
    type                = "VirtualMachineScaleSets"
    vm_size             = "Standard_D8s_v4"
    os_disk_size_gb     = 256
    enable_auto_scaling = true
    availability_zones  = [3]
  }

  subnet_id = module.boilerplate_subnet.id

  network_profile = {
    network_plugin     = "azure"
    network_policy     = "azure"
    service_cidr       = "10.245.14.0/23"
    dns_service_ip     = "10.245.14.10"
    docker_bridge_cidr = "172.17.0.1/16"
  }


  role_name             = "AcrPull"
  container_registry_id = module.boilerplate_container_registry.id
}