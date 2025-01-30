##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  default_tags {
    tags = local.tags
  }
}

terraform {

  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.51.0"
    }
  }

  backend "s3" { }
}
