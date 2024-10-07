variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "DigitalOcean region"
  default     = "sgp1"
}

variable "container_registry" {
  type        = string
  description = "DigitalOcean Container Registry name"
  default     = "group3"
}

// DATABASE

variable "db_username" {
  type        = string
  description = "Username for the PostgreSQL database"
}

variable "db_name" {
  type        = string
  description = "Name of the application database"
  default     = "postgres"
}