# IAC with Terraform

Terraform is used to provision infrastructure through Infrastructure as Code (IAC) in this project.

## Getting Started

1. Ensure that Terraform is installed on your machine. Installation link can be found [here](https://developer.hashicorp.com/terraform/install).
2. You will need to create your own DigitalOcean token for Terraform to provision the infrastructure with. Refer [here](https://docs.digitalocean.com/reference/api/create-personal-access-token/) for instructions on how to create your own Personal Access Token.
3. Duplicate the file `terraform.tfvars.example` and rename it as `terraform.tfvars`. This will be the secrets or environment variables to use in Terraform's execution plan.
4. Replace `do_token` in `terraform.tfvars` with your DigitalOcean Personal Access Token from step (2)
5. Check that the terraform files are valid with `terraform validate`.
6. Run `terraform init` to perform backend initalisation, child module installation, and plugin installation.
7. Run `terraform plan` to see the resources to be created.
8. Run `terraform apply` to create/update the infrastructure. This step will potentially take more than 10 minutes for a brand new creation. Subsequent runs will take a shorter duration as it relies on the `terraform.tfstate` to remember the infrastructure state.

## Infrastructure

WIP: to fill up provisioned infrastructure


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