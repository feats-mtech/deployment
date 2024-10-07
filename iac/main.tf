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
  name    = "app-cluster"
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

# Kubernetes load balancer for external traffic
resource "digitalocean_loadbalancer" "app_lb" {
  name   = "app-lb"
  region = var.region
  forwarding_rule {
    entry_protocol  = "http"
    entry_port      = 80
    target_protocol = "http"
    target_port     = 80
  }
  droplet_tag = "k8s-node"
}

# PostgreSQL Database
resource "digitalocean_database_cluster" "postgresql" {
  name       = "postgres"
  engine     = "pg"
  version    = "13"
  size       = "db-s-2vcpu-4gb"
  region     = var.region
  node_count = 1

  private_network_uuid = digitalocean_vpc.app_vpc.id
}

resource "digitalocean_database_user" "db_user" {
  cluster_id = digitalocean_database_cluster.postgresql.id
  name       = var.db_username
}

resource "digitalocean_database_db" "app_db" {
  cluster_id = digitalocean_database_cluster.postgresql.id
  name       = var.db_name
}

resource "digitalocean_database_replica" "postgresql_replica" {
  cluster_id = digitalocean_database_cluster.postgresql.id
  name       = "postgres-replica"
  size       = "db-s-2vcpu-4gb"
  region     = var.region
}