variable "db_username" {
  description = "Username master del database PostgreSQL"
  type        = STRING
  default     = "dbuser"
}

variable "db_password" {
  description = "Password master del database PostgreSQL"
  type        = STRING
  sensitive   = true
}