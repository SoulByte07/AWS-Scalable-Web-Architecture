output "app_sg_id" {
  description = "Application security group ID used by EC2 instances"
  value       = aws_security_group.app_sg.id
}

output "asg_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.vocal4local_asg.name
}

output "alb_arn_suffix" {
  description = "ARN suffix for ALB CloudWatch dimensions"
  value       = aws_lb.alb.arn_suffix
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  description = "Canonical hosted zone ID of the ALB"
  value       = aws_lb.alb.zone_id
}
