variable "resource_group" {
  description = "Azure resource group information"
  type = object({
    name     = string
    location = optional(string, "East US")
  })
}

variable "name" {
  description = "Name of the Web App"
  type        = string
}

variable "os_type" {
  description = "Operating system type (Linux or Windows)"
  type        = string
  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "OS type must be either 'Linux' or 'Windows'."
  }
}

variable "app_service_plan_id" {
  type = string
}

variable "always_on" {
  description = "Whether the application should remain always on"
  type        = bool
  default     = true
}

variable "app_command_line" {
  description = "Startup command for the application (optional)"
  type        = string
  default     = null
}

variable "node_version" {
  description = "NodeJS version to use"
  type        = string
  default     = null
}

variable "app_settings" {
  description = "Additional application configuration settings"
  type        = map(string)
  default     = {}
}

variable "docker_image" {
  description = "Docker image configuration to use"
  type = object({
    name = string
    tag  = string
  })
  default = null
}