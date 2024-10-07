terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# DigitalOcean Kubernetes Cluster
resource "digitalocean_kubernetes_cluster" "app_cluster" {
  name    = var.cluster_name
  region  = var.region
  version = "1.31.1-do.1"

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

# VPC for secure networking
resource "digitalocean_vpc" "app_vpc" {
  name   = "app-vpc"
  region = var.region
}