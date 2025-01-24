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

variable "domain_name" {
  type        = string
  description = "Domain name"
  # default     = ""
}
