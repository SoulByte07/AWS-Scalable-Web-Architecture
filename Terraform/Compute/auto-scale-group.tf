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

  # Keep outbound scope minimal for learning:
  # - HTTPS for package updates and AWS APIs
  # - DNS to VPC resolver for name resolution
  egress {
    description = "Allow HTTPS outbound"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow DNS UDP to VPC resolver"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow DNS TCP to VPC resolver"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
}

resource "aws_launch_template" "vocal4local_lt" {
  name_prefix            = "vocal4local-template-"
  image_id               = local.selected_ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  metadata_options {
    # Require IMDSv2 to reduce metadata service abuse risk.
    http_tokens = "required"
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      encrypted             = true
      volume_size           = 20
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  # Bootstraps a basic Apache page that shows the instance private IP.
  user_data = base64encode(<<-EOF
    #!/bin/bash
    # Update packages and install Apache web server
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    
    # Fetch the server's private IP dynamically using AWS metadata
    TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    LOCAL_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)
    
    # Create the HTML landing page
    echo "<div style='text-align:center; margin-top:50px; font-family:sans-serif;'>" > /var/www/html/index.html
    echo "<h1>🛍️ Vocal4Local Simulation</h1>" >> /var/www/html/index.html
    echo "<h3>Infrastructure is LIVE!</h3>" >> /var/www/html/index.html
    echo "<p>Serving traffic from instance: <b style='color:green;'>$LOCAL_IP</b></p>" >> /var/www/html/index.html
    echo "</div>" >> /var/www/html/index.html
  EOF
  )
}


resource "aws_autoscaling_group" "vocal4local_asg" {
  name                = "vocal4local-asg"
  vpc_zone_identifier = var.private_subnet_ids                   # Spans across Multi-AZ private subnets
  target_group_arns   = [aws_lb_target_group.vocal4local_tg.arn] # Connects to ALB

  desired_capacity          = 2
  min_size                  = 2
  max_size                  = 4
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.vocal4local_lt.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "cpu_tracking_policy" {
  name                   = "vocal4local-cpu-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.vocal4local_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    # Scale up if average CPU hits 70% across instances
    target_value = 70.0
  }
}
