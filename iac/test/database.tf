resource "digitalocean_database_cluster" "postgresql" {
  name       = var.db_name
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

# Execute SQL initialization script
resource "null_resource" "init_db" {
  depends_on = [digitalocean_database_cluster.postgresql, digitalocean_database_user.db_user]

  provisioner "local-exec" {
    command = <<EOT
      psql "host=${digitalocean_database_cluster.postgresql.host} port=25060 user=${var.db_username} password=${digitalocean_database_user.db_user.password} dbname=defaultdb" -f ${path.module}/../../scripts/db-combined.sql
    EOT
  }
}

resource "digitalocean_database_replica" "postgresql_replica" {
  cluster_id = digitalocean_database_cluster.postgresql.id
  name       = "postgres-replica-test"
  size       = "db-s-2vcpu-4gb"
  region     = var.region
}