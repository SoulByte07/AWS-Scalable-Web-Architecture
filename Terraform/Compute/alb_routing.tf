resource "aws_lb_target_group" "vocal4local_tg" {
  name     = "vocal4local-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  # Health check ensures ALB only sends traffic to healthy instances
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = var.alb_arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vocal4local_tg.arn
  }
}

