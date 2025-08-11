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

variable "app_service_plan_id" {
  type     = string
  nullable = false
}

variable "storage_account" {
  type = object({
    name               = string
    primary_access_key = string
  })
  nullable = false
}

variable "site_config" {
  type = object({
    always_on                              = optional(bool)
    http2_enabled                          = optional(bool)
    app_command_line                       = optional(string)
    ftps_state                             = optional(string)
    linux_fx_version                       = optional(string)
    application_insights_key               = optional(string)
    application_insights_connection_string = optional(string)
    application_stack = optional(object({
      use_dotnet_isolated_runtime = optional(bool)
      use_custom_runtime          = optional(bool)
      node_version                = optional(string)
      python_version              = optional(string)
      docker                      = optional(object({}))
    }))
  })
  default = {}
}

variable "ip_restrictions" {
  description = "List of IP restriction configurations"
  type = list(object({
    action = string
    headers = list(object({
      x_azure_fdid      = optional(list(string))
      x_fd_health_probe = optional(list(string))
      x_forwarded_for   = optional(list(string))
      x_forwarded_host  = optional(list(string))
    }))
    name        = string
    priority    = number
    service_tag = string
  }))
  default = []
}

variable "allowed_origins" {
  description = "List of allowed origins for CORS"
  type        = list(string)
  default     = []
}

variable "virtual_network_subnet_id" {
  description = "Subnet Id"
  type        = string
  default     = null
}