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
| <a name="output_db_secret_arn"></a> [db\_secret\_arn](#output\_db\_secret\_arn) | The ARN of the Secrets Manager secret containing the DB credentials |
