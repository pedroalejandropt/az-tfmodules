variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "name" {
  type    = string
  default = "myVNet"
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}