variable "db_username" {
  description = "Username master del database PostgreSQL"
  type        = string
  default     = "dbuser"
}

variable "db_password" {
  description = "Password master del database PostgreSQL"
  type        = string
  sensitive   = true
}
# commento per aggiornare stato commit