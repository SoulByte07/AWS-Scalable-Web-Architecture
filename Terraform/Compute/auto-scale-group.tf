resource "aws_autoscaling_group" "auto_scaling_group" {
  max_size = 5
  min_size = 2 
  health_check_grace_period = 300
  health_check_type         = "alb"
  desired_capacity          = 4
  force_delete              = true
  launch_configuration      = aws_launch_configuration.foobar.name
  vpc_zone_identifier       = [aws_subnet.private_subnet.id]
  availability_zones         = ["ap-south-1a", "ap-south-1b"]


  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }
}
