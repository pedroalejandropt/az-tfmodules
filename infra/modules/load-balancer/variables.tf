variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
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