resource "azurerm_kubernetes_cluster" "kube_cluster" {
  name                      = var.name
  location                  = var.resource_group_location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.name
  kubernetes_version        = var.kubernetes_version
  sku_tier                  = "Standard"
  automatic_channel_upgrade = var.automatic_channel_upgrade

  default_node_pool {
    name                = var.node_name
    node_count          = var.node_count
    vm_size             = var.node_vm_size
    os_disk_size_gb     = var.node_os_disk_size_gb
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.node_min_count
    max_count           = var.node_max_count
    type                = "VirtualMachineScaleSets"
    zones               = var.availability_zones
    vnet_subnet_id      = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = "172.17.0.1/16"
  }

  ## block access from other ip
  # api_server_access_profile {
  #   authorized_ip_ranges = [
  #     "5.102.146.111/32"
  #   ]
  # }

  // TODO: check later
  /* dynamic "tags" {
    for_each    = []
    Environment = "Production"
  } */
}

resource "azurerm_role_assignment" "role_assignment" {
  principal_id                     = azurerm_kubernetes_cluster.kube_cluster.kubelet_identity.0.object_id
  role_definition_name             = var.role_name
  scope                            = var.container_registry_id
  skip_service_principal_aad_check = true

  depends_on = [
    azurerm_kubernetes_cluster.kube_cluster
  ]
}