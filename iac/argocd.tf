provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  set {
    name  = "server.service.type"
    # value = "ClusterIP" # Using ClusterIP since Ingress will handle external traffic
    value = "LoadBalancer"
  }

  set {
    name  = "configs.argoServer.enableInsecure"
    # value = "false" # SSL termination handled by Ingress
    value = "true"  # Set to false in production
  }

  # Enable Ingress with TLS
  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set {
    name  = "server.ingress.tls[0].secretName"
    value = "argocd-tls-cert"
  }

  depends_on = [kubernetes_namespace.argocd]
}

resource "kubernetes_secret" "argocd_tls_secret" {
  metadata {
    name      = "argocd-tls-cert"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }
  data = {
    "tls.crt" = filebase64("tls.crt")  # TLS certificate
    "tls.key" = filebase64("tls.key")  # TLS private key
  }
}

data "kubernetes_secret" "argocd_admin_password" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }
}

# Fetch the LoadBalancer service for argocd-server
data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }
}