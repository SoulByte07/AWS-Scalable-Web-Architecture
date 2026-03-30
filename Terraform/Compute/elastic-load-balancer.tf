resource "aws_elastic_load_balancer" "elb" {
  name               = "elb"
  availability_zones = ["south-1a", "south-1b", "south-1c"]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Environment = "production"
  }
}
