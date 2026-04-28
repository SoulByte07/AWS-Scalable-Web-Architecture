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
| <a name="provider_aws.us_east_1"></a> [aws.us\_east\_1](#provider\_aws.us\_east\_1) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_bucket_name_prefix"></a> [bucket\_name\_prefix](#input\_bucket\_name\_prefix) | Prefix used to build unique S3 bucket names | `string` | n/a | yes |
| <a name="input_cloudfront_acm_certificate_arn"></a> [cloudfront\_acm\_certificate\_arn](#input\_cloudfront\_acm\_certificate\_arn) | ACM certificate ARN in us-east-1 for CloudFront custom domain | `string` | `null` | no |
| <a name="input_enable_custom_domain"></a> [enable\_custom\_domain](#input\_enable\_custom\_domain) | Enable CloudFront custom domain | `bool` | n/a | yes |
| <a name="input_frontend_domain_name"></a> [frontend\_domain\_name](#input\_frontend\_domain\_name) | Primary custom domain served by CloudFront | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | CloudFront distribution domain name |
| <a name="output_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#output\_cloudfront\_hosted\_zone\_id) | CloudFront hosted zone ID for Route53 alias records |
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
