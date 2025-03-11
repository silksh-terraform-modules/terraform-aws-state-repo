module "state_repo" {
  source = "github.com/silksh-terraform-modules/terraform-aws-state-repo?ref=v0.0.2"

  repo_prefix = var.project_full_name
}

# backend usage
# terraform {
#   required_version = "~> 1.11"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.90"
#     }
#   }
#   backend "s3" {
#     bucket       = "${var.project_full_name}-terraform-up-and-running-state"
#     key          = "terraform.tfstate"
#     region       = var.region
#     use_lockfile = true
#     encrypt      = true
#   }
# }
