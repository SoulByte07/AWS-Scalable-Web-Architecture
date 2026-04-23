# variable.tf
variable "availability_zones" {
  description = "AZs for High Availability"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type    = string
  default = "ami-0c94855ba95c71c99"
}

variable "alb_acm_certificate_arn" {
  description = "ACM certificate ARN for the ALB HTTPS listener"
  type        = string
}


# Compute
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

variable "public_subnet_ids" {
  type = list(string)
}

variable "aws_ami" {
  type    = string
  default = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 Mumbai
}


# Network 
# variable "availability_zones" {
#   type    = list(string)
#   default = ["ap-south-1a", "ap-south-1b"]
# }

variable "create_elastic_ip" {
  type    = bool
  default = true
}


# Storage 
variable "private_db_subnets" {
  description = "List of Private Subnet IDs strictly for the database"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "The Security Group ID for the RDS instance"
  type        = string
}



# Security 
# variable "vpc_id" {
#   description = "The ID of the VPC where security groups will be created"
#   type        = string
# }
