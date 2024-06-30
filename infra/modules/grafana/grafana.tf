provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Ruta al archivo kubeconfig de AKS
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "prometheus-community"
  chart      = "prometheus"
  namespace  = "monitoring" # Namespace donde se desplegará Prometheus

  set {
    name  = "alertmanager.persistentVolume.storageClass"
    value = "default"
  }

  set {
    name  = "server.persistentVolume.storageClass"
    value = "default"
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "grafana/grafana"
  chart      = "grafana"
  namespace  = "default" # Namespace donde se desplegará Grafana

  set {
    name  = "adminUser"
    value = "admin" # Usuario administrador de Grafana
  }

  set {
    name  = "adminPassword"
    value = "admin" # Contraseña del usuario administrador (ajusta según tus políticas de seguridad)
  }

  set {
    name  = "service.type"
    value = "LoadBalancer" # Tipo de servicio para exponer Grafana fuera del clúster
  }
}