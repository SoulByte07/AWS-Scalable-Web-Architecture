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
| <a name="input_db_security_group_id"></a> [db\_security\_group\_id](#input\_db\_security\_group\_id) | The Security Group ID for the RDS instance | `string` | n/a | yes |
| <a name="input_private_db_subnets"></a> [private\_db\_subnets](#input\_private\_db\_subnets) | List of Private Subnet IDs strictly for the database | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_db_instance_id"></a> [db\_instance\_id](#output\_db\_instance\_id) | RDS DB instance identifier |
| <a name="output_db_instance_identifier"></a> [db\_instance\_identifier](#output\_db\_instance\_identifier) | RDS DB instance identifier for CloudWatch dimensions |
| <a name="output_db_secret_arn"></a> [db\_secret\_arn](#output\_db\_secret\_arn) | The ARN of the Secrets Manager secret containing the DB credentials |
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
