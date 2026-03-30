resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "webserver security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}
