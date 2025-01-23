# ECS Fargate Terraform infrastructure

These are Terraform configurations for a ECS Fargate Project.

## Credentials configurations

```sh
export AWS_REGION="eu-west-2"
export AWS_PROFILE="ENV_PROFILE" # development or production
```

## Instruction for new Configuration

Make sure you have got the required version and correct AWS_PROFILE. Furthermore install the [terraform-docs](https://github.com/terraform-docs/terraform-docs) to generate the project `Readme.md` file locally on the module.

```sh
# Initialize the Terraform project.
terraform init -backend-config=dev.config
```

```sh
# Make your changes and then format and validate it
terraform fmt
terraform validate
```

```sh
# Update Readme page if related configuration done
terraform-docs markdown . > Readme.md
```

```sh
# Generate and Review the Execution Plan. Example in dev.
terraform plan -var-file=dev.config -var-file=dev.tfvars
```

```sh
# Apply. Example in dev.
terraform apply -var-file=dev.config -var-file=dev.tfvars
```

## Misc

- To generate documentation we are using terraform-docs [here](https://github.com/terraform-docs/terraform-docs). A github action will be added to generate terraform docs [here](https://github.com/terraform-docs/terraform-docs?tab=readme-ov-file#using-github-actions)
- Hashicorp module structure [here](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
