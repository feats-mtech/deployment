# IAC with Terraform

Terraform is used to provision infrastructure through Infrastructure as Code (IAC) in this project.

## Getting Started

1. Ensure that Terraform is installed on your machine. Installation link can be found [here](https://developer.hashicorp.com/terraform/install).
2. You will need to create your own DigitalOcean token for Terraform to provision the infrastructure with. Refer [here](https://docs.digitalocean.com/reference/api/create-personal-access-token/) for instructions on how to create your own Personal Access Token.
3. Duplicate the file `terraform.tfvars.example` and rename it as `terraform.tfvars`. This will be the secrets or environment variables to use in Terraform's execution plan.
4. Replace `do_token` in `terraform.tfvars` with your DigitalOcean Personal Access Token from step (2).
5. Generate a ssh keypair (refer below for steps).
6. Check that the terraform files are valid with `terraform validate`.
7. Run `terraform init` to perform backend initalisation, child module installation, and plugin installation.
8. Run `terraform plan` to see the resources to be created.
9. Run `terraform apply` to create/update the infrastructure. This step may take more than 10 minutes for a brand new creation. Subsequent runs will take a shorter duration as it relies on the `terraform.tfstate` to remember the infrastructure state.

## Infrastructure

| File            | Infrastructure               |
| --------------- | ---------------------------- |
| `main.tf`       | K8 cluster, VPC              |
| `database.tf`   | Postgresql DB with replica   |
| `firewall.tf`   | Firewall                     |
| `grafana.tf`    | Grafana services             |
| `argocd.tf`     | ArgoCD services              |

## Commands

```sh
# Performs backend initialisation, child module installation, and plugin installation
terraform init

# Validate configuration files and does not access any remote state or services
terraform validate
terraform validate -json

# Generate an execution plan, showing actions taken without execution
terraform plan

# Create or update infrastructure depending on the configuration files
terraform apply

# Destroy the infrastructure managed by Terraform
terraform destroy

# Show the state file in a human-readable format
terraform show

# List all the outputs currently held in your state file
terraform output

# Create a DOT-formatted graph
terraform graph   
```

## Generating keys

You will need to [generate a ssh keypair](https://blog.saintmalik.me/argocd-on-kubernetes-cluster/#-step-1---generate-ssh-keypairs). This will generate two files for you, `argo` which holds the private ssh key and `argo.pub` which holds the public ssh key

```sh
ssh-keygen -t ed25519 -N '' -f argo
```