resource "azurerm_role_assignment" "role_assignment" {
  principal_id                     = var.k8_cluster_id
  role_definition_name             = var.role_name
  scope                            = var.container_registry_id
  skip_service_principal_aad_check = true
}