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