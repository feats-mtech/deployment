# resource "helm_release" "grafana" {
#   name       = "grafana"
#   repository = "https://grafana.github.io/helm-charts"
#   chart      = "grafana"
#   namespace  = "monitoring"

#   set {
#     name  = "service.type"
#     value = "LoadBalancer"
#   }

#   set {
#     name  = "adminPassword"
#     value = "your-grafana-admin-password" # Secure your Grafana admin password
#   }

#   set {
#     name  = "persistence.enabled"
#     value = "true"
#   }

#   set {
#     name  = "persistence.size"
#     value = "10Gi"
#   }

#   set {
#     name  = "persistence.storageClassName"
#     value = "do-block-storage"
#   }
# }