variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type    = string
  default = "ami-0c94855ba95c71c99"
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

variable "aws_ami" {
  type    = string
  default = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 Mumbai
}
