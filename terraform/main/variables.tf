##################################################################################
# VARIABLES
##################################################################################

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-2"
}

variable "environment" {
  type        = string
  description = "Environment name (production, development ...)."
}

variable "project" {
  type        = string
  description = "Project description."
  default     = "Main/ECS configurations"
}

variable "terraform_github_repo" {
  type        = string
  description = "GitHub repository name where Terraform configurations are"
}

variable "ecr_repo_name" {
  type        = string
  description = "ECR Repository name"
}

variable "container_port" {
  type        = number
  description = "Container port number. Must be same port EXPOSED on the Dockerfile"
  default     = 3000
}

variable "fargate_cpu" {
  type        = number
  description = "Fargate CPU."
  default     = 256
}

variable "fargate_memory" {
  type        = number
  description = "Fargate memory."
  default     = 512
}

variable "ecr_tag_name" {
  type        = string
  description = "ECR Tag name.."
  default     = "latest"
}

variable "environment_variables" {
  description = "The environment variables to pass to the container"
  type        = list(object({ name = string, value = string }))
}
