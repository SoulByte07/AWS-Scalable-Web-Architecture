A utility to generate documentation from Terraform modules in various output formats

Usage:
  terraform-docs [PATH] [flags]
  terraform-docs [command]

Available Commands:
  asciidoc    Generate AsciiDoc of inputs and outputs
  completion  Generate shell completion code for the specified shell (bash, zsh, fish)
  help        Help about any command
  json        Generate JSON of inputs and outputs
  markdown    Generate Markdown of inputs and outputs
  pretty      Generate colorized pretty of inputs and outputs
  tfvars      Generate terraform.tfvars of inputs
  toml        Generate TOML of inputs and outputs
  version     Print the version number of terraform-docs
  xml         Generate XML of inputs and outputs
  yaml        Generate YAML of inputs and outputs

Flags:
  -c, --config string               config file name (default ".terraform-docs.yml")
      --footer-from string          relative path of a file to read footer from (default "")
      --header-from string          relative path of a file to read header from (default "main.tf")
  -h, --help                        help for terraform-docs
      --hide strings                hide section [all, data-sources, footer, header, inputs, modules, outputs, providers, requirements, resources]
      --lockfile                    read .terraform.lock.hcl if exist (default true)
      --output-check                check if content of output file is up to date (default false)
      --output-file string          file path to insert output into (default "")
      --output-mode string          output to file method [inject, replace] (default "inject")
      --output-template string      output template (default "<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_alb_acm_certificate_arn"></a> [alb\_acm\_certificate\_arn](#input\_alb\_acm\_certificate\_arn) | ACM certificate ARN for the ALB HTTPS listener | `string` | `null` | no |
| <a name="input_alb_security_group_id"></a> [alb\_security\_group\_id](#input\_alb\_security\_group\_id) | The Security Group ID of the ALB | `string` | n/a | yes |
| <a name="input_ami_id_override"></a> [ami\_id\_override](#input\_ami\_id\_override) | Optional AMI ID override for EC2 instances | `string` | `""` | no |
| <a name="input_ami_ssm_parameter"></a> [ami\_ssm\_parameter](#input\_ami\_ssm\_parameter) | SSM parameter path for the AMI used by EC2 instances | `string` | `"/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"` | no |
| <a name="input_bucket_name_prefix"></a> [bucket\_name\_prefix](#input\_bucket\_name\_prefix) | Prefix used to build unique S3 bucket names | `string` | n/a | yes |
| <a name="input_enable_alb_https"></a> [enable\_alb\_https](#input\_enable\_alb\_https) | Enable HTTPS listener on ALB | `bool` | `false` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of Private Subnet IDs for the ASG | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR range of the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alb_arn_suffix"></a> [alb\_arn\_suffix](#output\_alb\_arn\_suffix) | ARN suffix for ALB CloudWatch dimensions |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | DNS name of the ALB |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | Canonical hosted zone ID of the ALB |
| <a name="output_app_sg_id"></a> [app\_sg\_id](#output\_app\_sg\_id) | Application security group ID used by EC2 instances |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | Auto Scaling Group name |
<!-- END_TF_DOCS -->")
      --output-values               inject output values into outputs (default false)
      --output-values-from string   inject output values from file into outputs (default "")
      --read-comments               use comments as description when description is empty (default true)
      --recursive                   update submodules recursively (default false)
      --recursive-include-main      include the main module (default true)
      --recursive-path string       submodules path to recursively update (default "modules")
      --show strings                show section [all, data-sources, footer, header, inputs, modules, outputs, providers, requirements, resources]
      --sort                        sort items (default true)
      --sort-by string              sort items by criteria [name, required, type] (default "name")
  -v, --version                     version for terraform-docs

Use "terraform-docs [command] --help" for more information about a command.
