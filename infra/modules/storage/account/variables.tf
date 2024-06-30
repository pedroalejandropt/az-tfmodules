variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
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