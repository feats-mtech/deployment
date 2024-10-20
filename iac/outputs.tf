output "kubernetes_cluster_name" {
  value = digitalocean_kubernetes_cluster.app_cluster.name
}

// DATABASE

output "postgresql_db_uri" {
  value     = digitalocean_database_cluster.postgresql.uri
  sensitive = true
}

output "postgresql_user" {
  value     = digitalocean_database_cluster.postgresql.user
  sensitive = true
}

output "db_user_password" {
  value       = digitalocean_database_user.db_user.password
  description = "The auto-generated password for the PostgreSQL user"
  sensitive   = true
}