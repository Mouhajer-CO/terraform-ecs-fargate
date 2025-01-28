################################################################################
# Locals & Data
################################################################################

locals {
  name = "vpc-${var.vpc_name}"

  count_azs = 2
  vpc_cidr  = "10.0.0.0/20" // TBD: Change to CIDR block var
  azs       = slice(data.aws_availability_zones.available.names, 0, local.count_azs)

  tags = {
    Project       = var.project
    Environment   = var.environment
    TerraformRepo = var.terraform_github_repo
  }
}

data "aws_availability_zones" "available" { state = "available" }

################################################################################
# VPC Registry
################################################################################

#tfsec:ignore:aws-ec2-no-excessive-port-access tfsec:ignore:aws-ec2-no-public-ingress-acl tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.1"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  create_igw         = true # Expose public subnet to the Internet
  enable_nat_gateway = true # Hide private subnet behind NAT Gateway for each Private Network
  single_nat_gateway = true # Provision one single nat gateway inside the VPC
}