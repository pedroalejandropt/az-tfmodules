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

variable "tier" {
  type    = string
  default = "Standard"
}


variable "replication_type" {
  type    = string
  default = "LRS"
}

variable "tags" {
  type    = list(string)
  default = []
}