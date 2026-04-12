output "alb_strict_sg_id" {
  description = "The ID of the security group for the Load Balancer"
  value       = aws_security_group.web_sg.id 
}

# This exports the ID so main.tf can see it and pass it to the Database
output "db_sg_id" {
  value = aws_security_group.web_sg.id 
}
