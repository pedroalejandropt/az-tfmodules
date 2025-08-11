variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  nullable = false
}

variable "name" {
  type = string
}

variable "log_workspace" {
  type = object({
    sku               = string
    retention_in_days = number
  })
  default = {
    sku               = "PerGB2018"
    retention_in_days = 30
  }
}

variable "container_app" {
  type = object({
    revision_mode = string
    secret_name   = string
    secret_value  = string
  })
  default = {
    revision_mode = "Single"
    secret_name   = null
    secret_value  = null
  }
}

variable "ingress" {
  type = object({
    target_port               = number
    external_enabled          = bool
    traffic_weight_percentage = number
    latest_revision           = bool
  })
  default = {
    target_port               = 3000
    external_enabled          = true
    traffic_weight_percentage = 100
    latest_revision           = true
  }
}

variable "registry" {
  type = object({
    server   = string
    username = string
  })
  default = {
    server   = null
    username = null
  }
}