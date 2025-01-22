################################################################################
# Locals & Data
################################################################################

locals {
  secret_name        = ""
  secret_description = "Secrets related to the CPE team."
  account_id         = data.aws_caller_identity.current.account_id

  tags = {
    Project       = var.project
    Environment   = var.environment
    TerraformRepo = var.terraform_github_repo
  }
}

data "aws_caller_identity" "current" {}

################################################################################
# Secrets Manager
################################################################################

module "secrets_manager" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "1.1.2"

  name                    = local.secret_name
  description             = local.secret_description
  kms_key_id              = null # Use default KMS key
  recovery_window_in_days = 7

  secret_string = jsonencode(var.secret_environment_variables)

  create_policy       = true
  block_public_policy = true
  policy_statements = {
    account = {
      sid = "AllowAccountGetandPut"
      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${local.account_id}:root"]
      }]
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = [
        "arn:aws:secretsmanager:eu-west-2:${local.account_id}:secret:*"
      ]
    }
  }
}
