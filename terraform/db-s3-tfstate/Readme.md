## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.51.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_log_tfstate_bucket"></a> [log\_tfstate\_bucket](#module\_log\_tfstate\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.2 |
| <a name="module_tfstate_bucket"></a> [tfstate\_bucket](#module\_tfstate\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.2 |
| <a name="module_tfstate_lock_table"></a> [tfstate\_lock\_table](#module\_tfstate\_lock\_table) | terraform-aws-modules/dynamodb-table/aws | 4.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (prod, dev ...). | `string` | n/a | yes |
| <a name="input_project_description"></a> [project\_description](#input\_project\_description) | Project description. | `string` | `"DynamoDB S3 tfstate configurations"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project Name. | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | Team name. | `string` | n/a | yes |
| <a name="input_terraform_github_repo"></a> [terraform\_github\_repo](#input\_terraform\_github\_repo) | GitHub repository name where Terraform configurations are | `string` | n/a | yes |

## Outputs

No outputs.
