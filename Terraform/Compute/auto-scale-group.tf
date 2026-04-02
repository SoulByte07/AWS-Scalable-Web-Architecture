resource "aws_security_group" "app_sg" {
  name        = "vocal4local-app-sg"
  description = "Allow inbound traffic from ALB only"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id] # Strict link to ALB!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Outbound via NAT Gateway
  }
}

resource "aws_launch_template" "vocal4local_lt" {
  name_prefix   = "vocal4local-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Vocal4Local-App-Server"
    }
  }
}

resource "aws_autoscaling_group" "vocal4local_asg" {
  name                = "vocal4local-asg"
  vpc_zone_identifier = var.private_subnet_ids # Spans across Multi-AZ private subnets
  target_group_arns   = [aws_lb_target_group.vocal4local_tg.arn] # Connects to ALB

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  launch_template {
    id      = aws_launch_template.vocal4local_lt.id
    version = "$Latest"
  }
}

