resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "webserver security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

# DB SG intentionally has no broad egress rules.
# Ingress for MySQL from app SG is defined in root `database_sg_rule.tf`.
resource "aws_security_group" "db_sg" {
  name        = "vocal4local-db-sg"
  description = "Allow MySQL from inside VPC"
  vpc_id      = var.vpc_id

  egress = []
}
