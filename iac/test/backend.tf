resource "kubernetes_secret" "feats_backend_secret" {
  metadata {
    name      = "feats-backend-secret"
    namespace = "default"
  }

  type = "Opaque"

  data = {
    POSTGRES_DB                = digitalocean_database_cluster.postgresql.database
    POSTGRES_K8_TEST_USER      = digitalocean_database_user.db_user.name
    POSTGRES_K8_TEST_PASSWORD  = digitalocean_database_user.db_user.password
    POSTGRES_K8_TEST_PORT      = digitalocean_database_cluster.postgresql.port
    POSTGRES_K8_TEST_IP        = digitalocean_database_cluster.postgresql.host
    GOOGLE_OAUTH_CLIENT_ID     = var.google_client_id
    GOOGLE_OAUTH_CLIENT_SECRET = var.google_client_secret
  }
}