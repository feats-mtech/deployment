variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true
}

variable "github_token" {
  type        = string
  description = "GitHub API token"
  sensitive   = true
}

variable "github_username" {
  type        = string
  description = "GitHub username"
  sensitive   = true
}

variable "ssh_private_key_path" {
  type        = string
  description = "SSH Private Key Path"
}
variable "ssh_public_key_path" {
  type        = string
  description = "SSH Public Key Path"
}

variable "deployment_repo_path" {
  type        = string
  description = "Deployment Repo Path"
  default     = "git@github.com:dmss-group3-practice-module/deployment.git"
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

variable "cluster_name" {
  type        = string
  description = "DigitalOcean K8 Cluster name"
  default     = "app-cluster"
}

// DATABASE
variable "db_name" {
  type        = string
  description = "Database name for the PostgreSQL database"
  sensitive   = true
}

variable "db_username" {
  type        = string
  description = "Username for the PostgreSQL database"
  sensitive   = true
}