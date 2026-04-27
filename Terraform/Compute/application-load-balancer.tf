# Internet-facing ALB in public subnets.
# Access logs are enabled for visibility.
resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.alb_security_group_id]

  subnets = var.public_subnets

  access_logs {
    bucket  = aws_s3_bucket.alb_logs.id
    prefix  = "AWSLogs"
    enabled = true
  }

  enable_deletion_protection = true

  tags = {
    Environment = "production"
    Project     = "Vocal4Local"
  }
}
