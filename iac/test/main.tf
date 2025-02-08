terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
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
  version = "1.32.1-do.0" // find valid version with "doctl kubernetes options versions"
  registry_integration = true

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.27.4"

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "configs.argoServer.enableInsecure"
    value = "true"  # Set to false in production
  }
  
  create_namespace = true
  
  depends_on = [digitalocean_kubernetes_cluster.app_cluster]

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  namespace  = "kube-system"
  chart      = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  version    = "3.8.2"

  create_namespace = false

  depends_on = [digitalocean_kubernetes_cluster.app_cluster]
}

# VPC for secure networking
resource "digitalocean_vpc" "app_vpc" {
  name   = "app-vpc-test"
  region = var.region
}

resource "null_resource" "save_kubeconfig" {
  // saves the kubeconfig to the local machine
  provisioner "local-exec" {
    command = "doctl kubernetes cluster kubeconfig save ${digitalocean_kubernetes_cluster.app_cluster.id}"
  }

  depends_on = [digitalocean_kubernetes_cluster.app_cluster]
}