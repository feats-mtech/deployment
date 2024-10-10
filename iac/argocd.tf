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

resource "github_repository_deploy_key" "argocd_repo_deploykey" {
  title      = "argocd-connect"
  repository = "deployment"
  key        = file(var.ssh_public_key_path)
  read_only  = true
}

resource "kubernetes_secret_v1" "ssh_key" {
  metadata {
    name      = "private-repo-ssh-key"
    namespace = kubernetes_namespace.argocd.id
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  type = "Opaque"

  data = {
    "sshPrivateKey" = file(var.ssh_private_key_path)
    "type"          = "git"
    "url"           = var.deployment_repo_path
    "name"          = "github"
    "project"       = "default"
  }
}

resource "github_repository_webhook" "argocd" {
  repository = "deployment"
  configuration {
    url          = "https://${data.kubernetes_service.argocd_server.status.0.load_balancer.0.ingress.0.ip}"
    content_type = "json"
    secret       = "skrrskrrrii" // secrets to avoid ddos if argo link is exposed. Just a random string
    insecure_ssl = true
  }

  active = true

  events = ["push"]
}

resource "kubernetes_manifest" "argocd_application" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "deployment"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.deployment_repo_path
        targetRevision = "main"
        path           = "k8s/test"  # Directory in the repo containing Kubernetes manifests
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default"  # Namespace for deployment
      }
      syncPolicy = {
        automated = {
          prune    = true  # Removes resources no longer defined in the repo
          selfHeal = true  # Auto-correct out-of-sync resources
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }

  depends_on = [helm_release.argocd]
}