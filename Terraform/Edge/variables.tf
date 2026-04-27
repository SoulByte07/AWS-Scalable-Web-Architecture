variable "bucket_name_prefix" {
  description = "Prefix used to build unique S3 bucket names"
  type        = string
}

variable "frontend_domain_name" {
  description = "Primary custom domain served by CloudFront"
  type        = string
}

variable "cloudfront_acm_certificate_arn" {
  description = "ACM certificate ARN in us-east-1 for CloudFront custom domain"
  type        = string
}
