variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  nullable = false
}

variable "name" {
  type    = string
  default = "myVNet"
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}