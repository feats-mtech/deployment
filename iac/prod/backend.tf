resource "kubernetes_secret" "feats_backend_secret" {
  metadata {
    name      = "feats-backend-secret"
    namespace = "default"
  }

  type = "Opaque"

  data = {
    POSTGRES_DB                = digitalocean_database_cluster.postgresql.database
    POSTGRES_K8_PROD_USER      = digitalocean_database_user.db_user.name
    POSTGRES_K8_PROD_PASSWORD  = digitalocean_database_user.db_user.password
    POSTGRES_K8_PROD_PORT      = digitalocean_database_cluster.postgresql.port
    POSTGRES_K8_PROD_IP        = digitalocean_database_cluster.postgresql.host
  }
}