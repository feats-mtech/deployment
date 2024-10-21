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