resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  # Assuming var.public_subnets is a list of your Multi-AZ subnet IDs
  subnets            = var.public_subnets 

  enable_deletion_protection = false

  tags = {
    Environment = "production"
    Project     = "Vocal4Local"
  }
}
