##################################################################################
# VARIABLES
##################################################################################

variable "environment" {
  type        = string
  description = "Environment name (prod, dev ...)."
}

variable "team" {
  type        = string
  description = "Team name."
}

variable "project_description" {
  type        = string
  description = "Project description."
  default     = "DynamoDB S3 tfstate configurations"
}

variable "project_name" {
  type        = string
  description = "Project Name."
}

variable "terraform_github_repo" {
  type        = string
  description = "GitHub repository name where Terraform configurations are"
}
