# File: Network/variables.tf

variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "create_elastic_ip" {
  type    = bool
  default = true
}
