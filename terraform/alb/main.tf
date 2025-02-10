################################################################################
# Locals & Data
################################################################################

locals {
  sg_description = "ecr-ecs-${var.ecr_repo_name}"

  tags = {
    Project       = var.project
    Environment   = var.environment
    TerraformRepo = var.terraform_github_repo
  }
}

################################################################################
# Application Load Balancer
################################################################################

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.8.0"

  name = "alb-ecr-ecs"

  load_balancer_type = "application"

  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets         = data.terraform_remote_state.vpc.outputs.public_subnets
  security_groups = [data.terraform_remote_state.vpc.outputs.security_group_id]

  enable_deletion_protection = false # Required if terraform needs to remove it

  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "alb-${local.sg_description} HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "alb-${local.sg_description} HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    all = {
      description = "alb-${local.sg_description} VPC egress traffic"
      ip_protocol = "-1"
      cidr_ipv4   = data.terraform_remote_state.vpc.outputs.cidr_block
    }
  }

  listeners = {
    l_http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    l_https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = data.terraform_remote_state.acm.outputs.acm_certificate_arn // var.acm_certificate_arn

      forward = {
        target_group_key = "tg_TBD_app"
      }
    }
  }

  target_groups = {
    tg_TBD_app = {
      backend_protocol = "HTTP"
      target_type      = "ip"
      backend_port     = var.container_port

      health_check = {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/start" // TODO: Change it
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
      }

      # There's nothing to attach here in this definition. Instead,
      # ECS will attach the IPs of the tasks to this target group
      create_attachment = false
    }
  }
}