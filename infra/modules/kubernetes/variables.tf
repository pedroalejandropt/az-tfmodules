variable "name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "k8_version" {
  type    = string
  default = "1.27"
}

variable "automatic_channel_upgrade" {
  type    = string
  default = "patch"
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  nullable = false
}

variable "node_pool" {
  type = object({
    name                = string
    count               = number
    max_pods            = number
    min_count           = number
    max_count           = number
    type                = string
    vm_size             = string
    os_disk_size_gb     = number
    enable_auto_scaling = bool
    availability_zones  = list(string)
  })
  default = {
    name                = "default-pool"
    count               = 1
    max_pods            = 110
    min_count           = 1
    max_count           = 100
    type                = "VirtualMachineScaleSets"
    vm_size             = "Standard_D8s_v4"
    os_disk_size_gb     = 256
    enable_auto_scaling = true
    availability_zones  = []
  }
}

variable "subnet_id" {
  type     = string
  nullable = false
}

variable "network_profile" {
  type = object({
    network_plugin     = string
    network_policy     = string
    service_cidr       = string
    dns_service_ip     = string
    docker_bridge_cidr = string
  })
  nullable = false
}

variable "tags" {
  type = list(object({
    tag_name  = string,
    tag_value = string
  }))
  default = []
}

variable "role_name" {
  type = string
}

variable "container_registry_id" {
  type = string
}