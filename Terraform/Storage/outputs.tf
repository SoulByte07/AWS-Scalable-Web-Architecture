output "db_instance_id" {
  description = "RDS DB instance identifier"
  value       = aws_db_instance.vocal4local_database.id
}

output "db_instance_identifier" {
  description = "RDS DB instance identifier for CloudWatch dimensions"
  value       = aws_db_instance.vocal4local_database.identifier
}
