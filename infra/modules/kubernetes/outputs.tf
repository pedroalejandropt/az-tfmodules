output "client_certificate" {
  value     = azurerm_kubernetes_cluster.kube_cluster.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.kube_cluster.kube_config_raw
  sensitive = true
}

output "id" {
  value     = azurerm_kubernetes_cluster.kube_cluster.kubelet_identity[0].object_id
  sensitive = true
}