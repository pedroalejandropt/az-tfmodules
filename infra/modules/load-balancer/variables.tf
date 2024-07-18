variable "name" {
  type = string
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  nullable = false
}

variable "sku" {
  type    = string
  default = "Standard"
}

variable "public_ip_list" {
  type = list(object({
    id   = string
    name = string
  }))
  default = []
}