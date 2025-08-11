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

variable "sku_tier" {
  type    = string
  default = "Free"
}

variable "sku_size" {
  type    = string
  default = "Free"
}

variable "custom_domains" {
  type = list(object({
    domain_name     = string
    validation_type = string
  }))
  default = []
}
