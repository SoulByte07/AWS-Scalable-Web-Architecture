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
