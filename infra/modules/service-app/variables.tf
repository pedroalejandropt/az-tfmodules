variable "resource_group" {
  description = "Azure resource group information"
  type = object({
    name     = string
    location = optional(string, "East US")
  })
}

variable "name" {
  description = "Name of the App Service Plan"
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

variable "sku_name" {
  description = "SKU for the App Service Plan"
  type        = string
  default     = "P1V2"
}