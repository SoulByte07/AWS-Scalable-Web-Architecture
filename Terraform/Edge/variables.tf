variable "bucket_name_prefix" {
  description = "Prefix used to build unique S3 bucket names"
  type        = string
}

variable "enable_custom_domain" {
  description = "Enable CloudFront custom domain"
  type        = bool
}

variable "frontend_domain_name" {
  description = "Primary custom domain served by CloudFront"
  type        = string
  default     = null
}

variable "cloudfront_acm_certificate_arn" {
  description = "ACM certificate ARN in us-east-1 for CloudFront custom domain"
  type        = string
  default     = null
}
