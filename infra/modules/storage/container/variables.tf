variable "name" {
  type = string
}

// blob, container or private
variable "access_type" {
  type    = string
  default = "blob"
}

variable "storage_account_name" {
  type = string
}