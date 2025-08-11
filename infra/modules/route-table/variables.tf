variable "name" {
  type = string
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "routes" {
  description = "List of routes to add to the route table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
}

variable "subnet_id" {
  description = "The ID of the subnet to associate the route table with."
  type        = string
}