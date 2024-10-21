data "kubernetes_secret" "argocd_admin_password" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
}

data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = "argocd"
  }
}

output "argocd_admin_password" {
  value = data.kubernetes_secret.argocd_admin_password.data.password
  sensitive = true
  depends_on = [data.kubernetes_secret.argocd_admin_password]
}

output "argocd_server_load_balancer_ip" {
  value = data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].ip
  description = "The external IP of the ArgoCD server LoadBalancer."
}