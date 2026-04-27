## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_alb_acm_certificate_arn"></a> [alb\_acm\_certificate\_arn](#input\_alb\_acm\_certificate\_arn) | ACM certificate ARN for the ALB HTTPS listener | `string` | n/a | yes |
| <a name="input_alb_security_group_id"></a> [alb\_security\_group\_id](#input\_alb\_security\_group\_id) | The Security Group ID of the ALB | `string` | n/a | yes |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | n/a | `string` | `"ami-0c94855ba95c71c99"` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | AZs for High Availability | `list(string)` | <pre>[<br/>  "ap-south-1a",<br/>  "ap-south-1b"<br/>]</pre> | no |
| <a name="input_aws_ami"></a> [aws\_ami](#input\_aws\_ami) | n/a | `string` | `"ami-0c55b159cbfafe1f0"` | no |
| <a name="input_create_elastic_ip"></a> [create\_elastic\_ip](#input\_create\_elastic\_ip) | n/a | `bool` | `true` | no |
| <a name="input_db_security_group_id"></a> [db\_security\_group\_id](#input\_db\_security\_group\_id) | The Security Group ID for the RDS instance | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_private_db_subnets"></a> [private\_db\_subnets](#input\_private\_db\_subnets) | List of Private Subnet IDs strictly for the database | `list(string)` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of Private Subnet IDs for the ASG | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
