module "state_repo" {
  source = "github.com/silksh-terraform-modules/terraform-aws-state-repo?ref=v0.0.1"
  
  repo_prefix = var.project_full_name

}