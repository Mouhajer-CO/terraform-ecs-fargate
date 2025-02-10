## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | 9.8.0 |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.acm](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container port number. Must be same port EXPOSED on the Dockerfile | `number` | `3000` | no |
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | ECR Repository name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (production, development ...). | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project description. | `string` | n/a | yes |
| <a name="input_terraform_github_repo"></a> [terraform\_github\_repo](#input\_terraform\_github\_repo) | GitHub repository name where Terraform configurations are | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ID and ARN of the load balancer we created |
| <a name="output_arn_suffix"></a> [arn\_suffix](#output\_arn\_suffix) | ARN suffix of our load balancer - can be used with CloudWatch |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The DNS name of the load balancer |
| <a name="output_id"></a> [id](#output\_id) | The ID and ARN of the load balancer we created |
| <a name="output_listener_rules"></a> [listener\_rules](#output\_listener\_rules) | Map of listeners rules created and their attributes |
| <a name="output_listeners"></a> [listeners](#output\_listeners) | Map of listeners created and their attributes |
| <a name="output_route53_records"></a> [route53\_records](#output\_route53\_records) | The Route53 records created and attached to the load balancer |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Amazon Resource Name (ARN) of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
| <a name="output_target_groups"></a> [target\_groups](#output\_target\_groups) | Map of target groups created and their attributes |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | The zone\_id of the load balancer to assist with creating DNS records |
