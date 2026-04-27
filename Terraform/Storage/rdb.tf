# Subnet group pins RDS to private subnets only.
resource "aws_db_subnet_group" "vocal4local_db_group" {
  name       = "vocal4local-db-subnet-group"
  subnet_ids = var.private_db_subnets

  tags = {
    Name = "Vocal4Local DB Subnet Group"
  }
}

# Core MySQL instance with baseline production-like safety settings.
resource "aws_db_instance" "vocal4local_database" {
  identifier        = "vocal4local-prod-db"
  allocated_storage = 20
  storage_type      = "gp3"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"

  multi_az = true
  db_name  = "vocal4local"
  username = "admin"

  # Let AWS manage the master password in Secrets Manager.
  manage_master_user_password = true

  # Encrypt storage at rest.
  storage_encrypted = true

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  deletion_protection     = true
  publicly_accessible     = false

  db_subnet_group_name   = aws_db_subnet_group.vocal4local_db_group.name
  vpc_security_group_ids = [var.db_security_group_id]

  skip_final_snapshot       = false
  final_snapshot_identifier = "vocal4local-final-snapshot"

  tags = {
    Environment = "production"
    Project     = "Vocal4Local"
  }
}

# Expose DB secret ARN so app tooling can fetch credentials securely.
output "db_secret_arn" {
  description = "The ARN of the Secrets Manager secret containing the DB credentials"
  value       = aws_db_instance.vocal4local_database.master_user_secret[0].secret_arn
}
