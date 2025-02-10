##################################################################################
# VARIABLES
##################################################################################

variable "environment" {
  type        = string
  description = "Environment name (production, development ...)."
}

variable "project" {
  type        = string
  description = "Project description."
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
