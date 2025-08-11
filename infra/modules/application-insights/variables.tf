variable "name" {
  type     = string
  nullable = false
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  nullable = false
}

variable "application_type" {
  type    = string
  default = "Node.JS"
}

variable "retention_in_days" {
  type    = number
  default = 30
}

variable "sku" {
  type    = string
  default = "PerGB2018"
}
