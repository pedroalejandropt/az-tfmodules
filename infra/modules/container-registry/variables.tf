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

variable "sku" {
  type    = string
  default = "Basic"
}

variable "admin_enabled" {
  type    = bool
  default = false
}