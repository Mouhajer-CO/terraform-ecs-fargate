################################################################################
# Output
################################################################################

output "secret_arn" {
  description = "The ARN of the secret"
  value       = module.secrets_manager.secret_arn
}

output "secret_id" {
  description = "The ID of the secret"
  value       = module.secrets_manager.secret_id
}

output "secret_replica" {
  description = "Attributes of the replica created"
  value       = module.secrets_manager.secret_replica
}

output "secret_version_id" {
  description = "The unique identifier of the version of the secret"
  value       = module.secrets_manager.secret_version_id
}
