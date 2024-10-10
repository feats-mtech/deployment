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

provider "github" {
  token = var.github_token
  owner = var.github_username
}

# DigitalOcean Kubernetes Cluster
resource "digitalocean_kubernetes_cluster" "app_cluster" {
  name    = var.cluster_name
  region  = var.region
  version = "1.31.1-do.2" // find valid version with "doctl kubernetes options versions"
  registry_integration = true

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

resource "null_resource" "save_kubeconfig" {
  // saves the kubeconfig to the local machine
  provisioner "local-exec" {
    command = "doctl kubernetes cluster kubeconfig save ${digitalocean_kubernetes_cluster.app_cluster.id}"
  }

  depends_on = [digitalocean_kubernetes_cluster.app_cluster]
}