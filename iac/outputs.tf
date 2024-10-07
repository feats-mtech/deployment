output "kubernetes_cluster_name" {
  value = digitalocean_kubernetes_cluster.app_cluster.name
}

# output "grafana_url" {
#   value = helm_release.grafana.url
# }

// DATABASE

output "postgresql_db_uri" {
  value     = digitalocean_database_cluster.postgresql.uri
  sensitive = true
}

output "postgresql_user" {
  value     = var.db_username
  sensitive = true
}

output "db_user_password" {
  value       = digitalocean_database_user.db_user.password
  description = "The auto-generated password for the PostgreSQL user"
  sensitive   = true
}