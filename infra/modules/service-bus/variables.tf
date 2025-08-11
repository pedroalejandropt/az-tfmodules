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

variable "queue_list" {
  type    = list(string)
  default = []
}

variable "sku" {
  type    = string
  default = "Basic"
}