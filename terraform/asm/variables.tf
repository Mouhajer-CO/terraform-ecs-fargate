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

variable "secret_environment_variables" {
  description = "The environment variables to pass to the container. Set these secrets on terraform.tfvars locally."
  type        = list(object({ name = string, value = string }))
}

variable "bucket" {
  type        = string
  description = "Backend bucket"
}

variable "key" {
  type        = string
  description = "Backend key"
}

variable "dynamodb_table" {
  type        = string
  description = "Backend dynamodb table"
}

variable "encrypt" {
  type        = bool
  description = "Backend encryption"
}
