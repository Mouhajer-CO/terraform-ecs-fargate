## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.51.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secrets_manager"></a> [secrets\_manager](#module\_secrets\_manager) | terraform-aws-modules/secrets-manager/aws | 1.1.2 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Backend bucket | `string` | n/a | yes |
| <a name="input_dynamodb_table"></a> [dynamodb\_table](#input\_dynamodb\_table) | Backend dynamodb table | `string` | n/a | yes |
| <a name="input_encrypt"></a> [encrypt](#input\_encrypt) | Backend encryption | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (production, development ...). | `string` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | Backend key | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project description. | `string` | n/a | yes |
| <a name="input_secret_environment_variables"></a> [secret\_environment\_variables](#input\_secret\_environment\_variables) | The environment variables to pass to the container. Set these secrets on terraform.tfvars locally. | `list(object({ name = string, value = string }))` | n/a | yes |
| <a name="input_terraform_github_repo"></a> [terraform\_github\_repo](#input\_terraform\_github\_repo) | GitHub repository name where Terraform configurations are | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | The ARN of the secret |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | The ID of the secret |
| <a name="output_secret_replica"></a> [secret\_replica](#output\_secret\_replica) | Attributes of the replica created |
| <a name="output_secret_version_id"></a> [secret\_version\_id](#output\_secret\_version\_id) | The unique identifier of the version of the secret |
