variable "alb_acm_certificate_arn" {
  description = "ACM certificate ARN for the ALB HTTPS listener"
  type        = string
  default     = null

  validation {
    condition     = !var.enable_alb_https || var.alb_acm_certificate_arn != null
    error_message = "Set alb_acm_certificate_arn when enable_alb_https is true."
  }
}

variable "enable_alb_https" {
  description = "Enable HTTPS listener on ALB"
  type        = bool
  default     = false
}

variable "bucket_name_prefix" {
  description = "Prefix used to build globally unique S3 bucket names"
  type        = string
  default     = "vocal4local"
}

variable "root_domain_name" {
  description = "Route53 hosted zone domain name (for example example.com)"
  type        = string
  default     = null

  validation {
    condition     = !var.enable_custom_domain || var.root_domain_name != null
    error_message = "Set root_domain_name when enable_custom_domain is true."
  }
}

variable "frontend_domain_name" {
  description = "CloudFront custom domain (for example app.example.com)"
  type        = string
  default     = null

  validation {
    condition     = !var.enable_custom_domain || var.frontend_domain_name != null
    error_message = "Set frontend_domain_name when enable_custom_domain is true."
  }
}

variable "cloudfront_acm_certificate_arn" {
  description = "ACM certificate ARN in us-east-1 for CloudFront custom domain"
  type        = string
  default     = null

  validation {
    condition     = !var.enable_custom_domain || var.cloudfront_acm_certificate_arn != null
    error_message = "Set cloudfront_acm_certificate_arn when enable_custom_domain is true."
  }
}

variable "enable_custom_domain" {
  description = "Enable Route53 record and CloudFront custom domain"
  type        = bool
  default     = false
}
