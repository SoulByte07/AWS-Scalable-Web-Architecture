## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where security groups will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alb_strict_sg_id"></a> [alb\_strict\_sg\_id](#output\_alb\_strict\_sg\_id) | The ID of the security group for the Load Balancer |
| <a name="output_db_sg_id"></a> [db\_sg\_id](#output\_db\_sg\_id) | This exports the ID so main.tf can see it and pass it to the Database |
