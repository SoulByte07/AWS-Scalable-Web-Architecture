variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of Private Subnet IDs for the ASG"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "The Security Group ID of the ALB"
  type        = string
}

variable "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  type        = string
}

