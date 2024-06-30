/* data "azurerm_key_vault" "terraform_vault" {
  name                = "kv-${var.name}"
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "LinuxSSHPubKey"
  key_vault_id = data.azurerm_key_vault.terraform_vault.id
}

data "azurerm_key_vault_secret" "spn_id" {
  name         = "spn-id"
  key_vault_id = data.azurerm_key_vault.terraform_vault.id
}
data "azurerm_key_vault_secret" "spn_secret" {
  name         = "spn-secret"
  key_vault_id = data.azurerm_key_vault.terraform_vault.id
} */

resource "azurerm_kubernetes_cluster" "kube_cluster" {
  name                = var.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name
  kubernetes_version  = var.kubernetes_version
  sku_tier            = "Standard"

  default_node_pool {
    name                = var.node_name
    node_count          = var.node_count
    vm_size             = var.node_vm_size
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.node_min_count
    max_count           = var.node_max_count
    type                = "VirtualMachineScaleSets"
    zones               = var.availability_zones
    vnet_subnet_id      = var.subnet_id
  }

  identity {
    type = "SystemAssigned" // TODO: check later
  }

  /* linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = data.azurerm_key_vault_secret.ssh_public_key.value
    }
  } */

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    #load_balancer_sku  = "standard"
    service_cidr       = "10.2.0.0/16" # Example of a non-conflicting CIDR range
    dns_service_ip     = "10.2.0.10"   # Example DNS IP within the service CIDR range
    docker_bridge_cidr = "172.17.0.1/16"
  }

  /* service_principal {
    client_id     = data.azurerm_key_vault_secret.spn_id.value
    client_secret = data.azurerm_key_vault_secret.spn_secret.value
  } */

  # depends_on = [azurerm_role_assignment.role_assignment]

  // TODO: check later
  /* dynamic "tags" {
    for_each    = []
    Environment = "Production"
  } */
}

resource "azurerm_role_assignment" "role_assignment" {
  //count                            = var.container_registry_id != null ? 1 : 0
  principal_id                     = azurerm_kubernetes_cluster.kube_cluster.kubelet_identity.0.object_id
  role_definition_name             = var.role_name
  scope                            = var.container_registry_id
  skip_service_principal_aad_check = true

  depends_on = [
    azurerm_kubernetes_cluster.kube_cluster
  ]
}