resource "aws_security_group" "alb_strict_sg" {
  name        = "vocal4local-alb-strict-sg"
  description = "Allow HTTPS from CloudFront ONLY"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    # AWS Managed Prefix List for CloudFront (Global)
    prefix_list_ids = ["pl-3b927c52"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

