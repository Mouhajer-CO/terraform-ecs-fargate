##################################################################################
# Locals
##################################################################################

locals {
  aws_account = data.aws_caller_identity.current.account_id
  // ToDo: Add acronym
  bucket_name = "tfstate-${var.project_name}-bucket-${var.team}-${var.environment}"
  table_name  = "tfstate-${var.project_name}-lock-table-${var.team}-${var.environment}"

  tags = {
    ProjectName        = var.project_name
    ProjectDescription = var.project_description
    Environment        = var.environment
    TerraformRepo      = var.terraform_github_repo
  }
}

data "aws_caller_identity" "current" {}

##################################################################################
# S3
##################################################################################

module "tfstate_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = local.bucket_name

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  logging = {
    target_bucket = module.log_tfstate_bucket.s3_bucket_id
    target_prefix = "log/tfstate/"
  }

  versioning = {
    status = true
  }
}

#tfsec:ignore:aws-s3-enable-bucket-logging
module "log_tfstate_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = "logs-${local.bucket_name}"

  access_log_delivery_policy_source_accounts = [local.aws_account]
  access_log_delivery_policy_source_buckets  = ["arn:aws:s3:::${local.bucket_name}"]

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning = {
    status = true
  }
}

##################################################################################
# Dynamodb
##################################################################################

module "tfstate_lock_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "4.0.1"

  name         = local.table_name
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]

  deletion_protection_enabled    = true
  point_in_time_recovery_enabled = true
  server_side_encryption_enabled = true
}
