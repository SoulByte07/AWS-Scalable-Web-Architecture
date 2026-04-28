## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_alb_acm_certificate_arn"></a> [alb\_acm\_certificate\_arn](#input\_alb\_acm\_certificate\_arn) | ACM certificate ARN for the ALB HTTPS listener | `string` | `null` | no |
| <a name="input_bucket_name_prefix"></a> [bucket\_name\_prefix](#input\_bucket\_name\_prefix) | Prefix used to build globally unique S3 bucket names | `string` | `"vocal4local"` | no |
| <a name="input_cloudfront_acm_certificate_arn"></a> [cloudfront\_acm\_certificate\_arn](#input\_cloudfront\_acm\_certificate\_arn) | ACM certificate ARN in us-east-1 for CloudFront custom domain | `string` | `null` | no |
| <a name="input_enable_alb_https"></a> [enable\_alb\_https](#input\_enable\_alb\_https) | Enable HTTPS listener on ALB | `bool` | `false` | no |
| <a name="input_enable_custom_domain"></a> [enable\_custom\_domain](#input\_enable\_custom\_domain) | Enable Route53 record and CloudFront custom domain | `bool` | `false` | no |
| <a name="input_frontend_domain_name"></a> [frontend\_domain\_name](#input\_frontend\_domain\_name) | CloudFront custom domain (for example app.example.com) | `string` | `null` | no |
| <a name="input_ops_alert_email"></a> [ops\_alert\_email](#input\_ops\_alert\_email) | Optional email endpoint for operational alerts | `string` | `null` | no |
| <a name="input_root_domain_name"></a> [root\_domain\_name](#input\_root\_domain\_name) | Route53 hosted zone domain name (for example example.com) | `string` | `null` | no |

## Outputs

No outputs.
