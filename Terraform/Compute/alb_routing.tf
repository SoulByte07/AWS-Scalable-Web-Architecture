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

# When HTTPS is enabled, keep port 80 open only to redirect traffic to 443.
resource "aws_lb_listener" "http_redirect_listener" {
  count             = var.enable_alb_https ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# When HTTPS is disabled, do not forward plaintext traffic to the app tier.
# This makes the fallback mode explicit for learning and avoids silent insecure defaults.
resource "aws_lb_listener" "http_block_listener" {
  count             = var.enable_alb_https ? 0 : 1
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "HTTPS is required. Set enable_alb_https=true and provide alb_acm_certificate_arn."
      status_code  = "403"
    }
  }
}

# Main TLS listener for production-style traffic.
resource "aws_lb_listener" "https_listener" {
  count             = var.enable_alb_https ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.alb_acm_certificate_arn
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vocal4local_tg.arn
  }
}
