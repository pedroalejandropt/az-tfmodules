variable "name" {
  type     = string
  nullable = false
}

variable "os_type" {
  type    = string
  default = "linux"
}

variable "func_version" {
  type    = string
  default = "~3"
}

variable "app_service_plan" {
  type = object({
    kind     = string
    reserved = bool
  })
  default = {
    kind     = "Linux"
    reserved = true
  }
}

variable "sku" {
  type = object({
    tier = string
    size = string
  })
  default = {
    tier = "Dynamic"
    size = "Y1"
  }
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  nullable = false
}

variable "storage_account" {
  type = object({
    name               = string
    primary_access_key = string
  })
  nullable = false
}