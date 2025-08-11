resource "azurerm_kubernetes_cluster" "kube_cluster" {
  name                      = var.name
  location                  = var.resource_group.location
  resource_group_name       = var.resource_group.name
  dns_prefix                = var.name
  kubernetes_version        = var.k8_version
  sku_tier                  = "Standard"
  automatic_channel_upgrade = var.automatic_channel_upgrade
  node_resource_group       = "${var.node_pool.name}-node-rg"

  default_node_pool {
    name                        = var.node_pool.name
    node_count                  = var.node_pool.count
    max_pods                    = var.node_pool.max_pods
    vm_size                     = var.node_pool.vm_size
    os_disk_size_gb             = var.node_pool.os_disk_size_gb
    enable_auto_scaling         = var.node_pool.enable_auto_scaling
    min_count                   = var.node_pool.min_count
    max_count                   = var.node_pool.max_count
    type                        = var.node_pool.type
    zones                       = var.node_pool.availability_zones
    vnet_subnet_id              = var.subnet_id
    temporary_name_for_rotation = "rotation"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = var.network_profile.network_plugin
    network_policy = var.network_profile.network_policy
    service_cidr   = var.network_profile.service_cidr
    dns_service_ip = var.network_profile.dns_service_ip
  }
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