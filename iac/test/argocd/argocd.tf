provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_username
}

resource "kubernetes_secret_v1" "ssh_key" {
  metadata {
    name      = "private-repo-ssh-key"
    namespace = "argocd"
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

resource "github_repository_deploy_key" "argocd_repo_deploykey" {
  title      = "argocd-connect"
  repository = "deployment"
  key        = file(var.ssh_public_key_path)
  read_only  = true
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

  depends_on = [data.kubernetes_service.argocd_server]
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
        targetRevision = "HEAD"
        path           = "k8s/test" # Directory in the repo containing Kubernetes manifests
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default"
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
}