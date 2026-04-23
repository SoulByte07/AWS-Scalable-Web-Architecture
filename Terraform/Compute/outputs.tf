output "app_sg_id" {
  description = "Application security group ID used by EC2 instances"
  value       = aws_security_group.app_sg.id
}
