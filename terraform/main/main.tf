################################################################################
# Locals & Data
################################################################################

locals {
  name = "ecr-ecs-${var.ecr_repo_name}"

  account_id = data.aws_caller_identity.current.account_id

  container_name = local.name
  container_port = var.container_port

  ecr_address_name = format("%v.dkr.ecr.%v.amazonaws.com", local.account_id, var.region)
  ecr_image        = "${local.ecr_address_name}/${var.ecr_repo_name}"

  tags = {
    Project       = var.project
    Environment   = var.environment
    TerraformRepo = var.terraform_github_repo
  }
}

data "aws_caller_identity" "current" {}

################################################################################
# ECS with Cluster and Service
################################################################################

#tfsec:ignore:aws-ec2-no-public-egress-sgr
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.11.1"

  cluster_name = "cluster-${local.name}"

  # Allocate 20% capacity to FARGATE and then split the remaining
  #          80% capacity 50/50 between FARGATE and FARGATE_SPOT.
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
        base   = 20
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  services = {
    (local.container_name) = {
      cpu    = var.fargate_cpu
      memory = var.fargate_memory

      force_new_deployment = true

      container_definitions = {
        (local.container_name) = {

          runtime_platform = {
            cpu_architecture        = "ARM64"
            operating_system_family = "LINUX"
          }

          essential   = true
          cpu         = var.fargate_cpu
          memory      = var.fargate_memory
          image       = local.ecr_image
          environment = var.environment_variables
          port_mappings = [{
            name          = local.container_name
            containerPort = local.container_port
            hostPort      = local.container_port
            protocol      = "tcp"
          }]

          # Requires access to write to root filesystem
          readonly_root_filesystem = false

          enable_cloudwatch_logging = false
          memory_reservation        = 100
        }
      }

      service_connect_configuration = {
        namespace = aws_service_discovery_http_namespace.this.arn
        service = {
          client_alias = {
            port     = local.container_port
            dns_name = local.container_name
          }
          port_name      = local.container_name
          discovery_name = local.container_name
        }
      }

      load_balancer = {
        service = {
          // ToDo: Add target groups key 
          target_group_arn = data.terraform_remote_state.alb.outputs.target_groups["TBD"].arn
          container_name   = local.container_name
          container_port   = local.container_port
        }
      }

      subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

      security_group_rules = {
        alb_ingress_ecr_ecs = {
          protocol                 = "tcp"
          type                     = "ingress"
          from_port                = local.container_port
          to_port                  = local.container_port
          description              = "Service ecr-ecs container port"
          source_security_group_id = data.terraform_remote_state.alb.outputs.security_group_id
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }
}

################################################################################
# Supporting Resources
################################################################################

resource "aws_service_discovery_http_namespace" "this" {
  name        = local.name
  description = "CloudMap namespace for ${local.name}"
}
