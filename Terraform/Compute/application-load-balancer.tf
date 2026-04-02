resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  
  security_groups    = [var.alb_security_group_id] 
  
  subnets            = var.public_subnets 

  enable_deletion_protection = false

  tags = {
    Environment = "production"
    Project     = "Vocal4Local"
  }
}
