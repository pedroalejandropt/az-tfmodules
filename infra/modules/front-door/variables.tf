variable "config" {
  type = object({
    env                 = string
    resource_group_name = string
    frontdoor_sku_name  = string
  })
}

variable "frontdoor_profile_name" {
  type = string
}

variable "frontdoor_endpoint_name" {
  type = string
}

variable "backend_pools" {
  type = list(object({
    name               = string
    host_name          = string
    origin_host_header = optional(string)
    http_port          = number
    https_port         = number
  }))
}

variable "routing_rules" {
  type = list(object({
    name                = string
    accepted_protocols  = list(string)
    patterns_to_match   = list(string)
    forwarding_protocol = string
    backend_pool_name   = string
    associated_domains  = list(string)
  }))
}

variable "custom_domains" {
  description = "List of custom domains to configure"
  type = list(object({
    name                = string
    host_name           = string
    route_names         = list(string)
    certificate_type    = string
    minimum_tls_version = string
  }))
  default = []
}

variable "cache" {
  type = object({
    enabled       = bool
    behavior      = optional(string)
    compression   = optional(bool)
    content_types = optional(list(string))
  })
  default = {
    enabled       = false
    behavior      = "IgnoreQueryString",
    compression   = false,
    content_types = []
  }
}