resource "instace_type" {
  type = string
  default = "t2.micro"
} 

resource "ami_id" {
  type = string
  default = "ami-0c94855ba95c71c99"
}


