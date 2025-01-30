################################################################################
# Locals & Data
################################################################################

locals {
  tags = {
    Project       = var.project
    Environment   = var.environment
    TerraformRepo = var.terraform_github_repo
  }
}

data "aws_caller_identity" "current" {}

################################################################################
# ECR Registry
################################################################################

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.2.0"

  repository_read_write_access_arns = [data.aws_caller_identity.current.arn]
  repository_name                   = var.ecr_repo_name
  repository_force_delete           = false
  repository_type                   = "private"

  # create_lifecycle_policy = true
  repository_lifecycle_policy = jsonencode({
    rules = [{
      rulePriority = 1,
      action       = { type = "expire" },
      description  = "Keep last 10 images and delete others",
      selection = {
        tagStatus     = "tagged",
        tagPrefixList = ["v"],
        countType     = "imageCountMoreThan",
        countNumber   = 10
      }
    }]
  })
}
