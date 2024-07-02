variable "resource_group_name" {
  type = string
}

variable "vnet_name" {
  type     = string
  nullable = false
}

variable "name" {
  type     = string
  nullable = false
}

variable "address_prefix" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}