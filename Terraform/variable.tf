variable "alb_acm_certificate_arn" {
  description = "ACM certificate ARN for the ALB HTTPS listener"
  type        = string
  default     = "arn:aws:acm:ap-south-1:111111111111:certificate/00000000-0000-0000-0000-000000000000"
}

variable "bucket_name_prefix" {
  description = "Prefix used to build globally unique S3 bucket names"
  type        = string
  default     = "vocal4local"
}

variable "root_domain_name" {
  description = "Route53 hosted zone domain name (for example example.com)"
  type        = string
  default     = "example.com"
}

variable "frontend_domain_name" {
  description = "CloudFront custom domain (for example app.example.com)"
  type        = string
  default     = "app.example.com"
}

variable "cloudfront_acm_certificate_arn" {
  description = "ACM certificate ARN in us-east-1 for CloudFront custom domain"
  type        = string
  default     = "arn:aws:acm:us-east-1:111111111111:certificate/00000000-0000-0000-0000-000000000000"
}
