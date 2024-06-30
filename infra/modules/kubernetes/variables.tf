variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.27"
}

variable "enable_auto_scaling" {
  type = bool
}

variable "availability_zones" {
  type    = list(string)
  default = []
}

variable "node_name" {
  type = string
}

variable "node_count" {
  type     = number
  nullable = true
  default  = 1
}

variable "node_min_count" {
  type     = number
  nullable = true
  default  = 1
}

variable "node_max_count" {
  type     = number
  nullable = true
  default  = 100
}

variable "node_vm_size" {
  type     = string
  nullable = true
  default  = "Standard_D2_v2"
}

variable "subnet_id" {
  type     = string
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

variable "ad_name" {
  type = string
}