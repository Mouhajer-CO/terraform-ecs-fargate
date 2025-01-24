################################################################################
# Locals & Data
################################################################################

locals {
  tags = {
    Domain        = var.domain_name
    Project       = var.project
    Environment   = var.environment
    TerraformRepo = var.terraform_github_repo
  }
}

data "aws_route53_zone" "this" {
  name = var.domain_name
}

################################################################################
# ECR Registry
################################################################################

module "acm" {
  source            = "terraform-aws-modules/acm/aws"
  version           = "5.0.1"
  validation_method = "DNS"

  domain_name         = var.domain_name
  zone_id             = data.aws_route53_zone.this.id
  wait_for_validation = true
}
