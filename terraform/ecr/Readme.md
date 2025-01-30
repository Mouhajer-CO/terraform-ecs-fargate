## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.51.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | terraform-aws-modules/ecr/aws | 2.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | Repository name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (production, development ...). | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project description. | `string` | n/a | yes |
| <a name="input_terraform_github_repo"></a> [terraform\_github\_repo](#input\_terraform\_github\_repo) | GitHub repository name where Terraform configurations are | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | Full ARN of the repository |
| <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name) | Name of the repository |
| <a name="output_repository_registry_id"></a> [repository\_registry\_id](#output\_repository\_registry\_id) | The registry ID where the repository was created |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | The URL of the repository (in the form `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`) |
