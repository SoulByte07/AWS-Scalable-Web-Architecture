variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id_override" {
  description = "Optional AMI ID override for EC2 instances"
  type        = string
  default     = ""
}

variable "ami_ssm_parameter" {
  description = "SSM parameter path for the AMI used by EC2 instances"
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

variable "private_subnet_ids" {
  description = "List of Private Subnet IDs for the ASG"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "The Security Group ID of the ALB"
  type        = string
}

variable "public_subnets" {
  type = list(string)
}

variable "alb_acm_certificate_arn" {
  description = "ACM certificate ARN for the ALB HTTPS listener"
  type        = string
  default     = null
}

variable "enable_alb_https" {
  description = "Enable HTTPS listener on ALB"
  type        = bool
  default     = false
}

variable "bucket_name_prefix" {
  description = "Prefix used to build unique S3 bucket names"
  type        = string
}
