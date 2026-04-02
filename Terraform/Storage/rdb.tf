resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "db_secret_vault" {
  name        = "vocal4local-prod-db-credentials"
  description = "Master password for the Vocal4Local RDS instance"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_secret_vault.id
  secret_string = random_password.db_password.result
}


resource "aws_db_subnet_group" "vocal4local_db_group" {
  name       = "vocal4local-db-subnet-group"
  subnet_ids = var.private_db_subnets 

  tags = {
    Name = "Vocal4Local DB Subnet Group"
  }
}

resource "aws_db_instance" "vocal4local_database" {
  identifier           = "vocal4local-prod-db"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro" 
  
  multi_az             = true 

  db_name              = "vocal4local"
  username             = "admin"
  password             = random_password.db_password.result
  
  db_subnet_group_name   = aws_db_subnet_group.vocal4local_db_group.name
  vpc_security_group_ids = [var.db_security_group_id]

  # TODO: Skip final snapshot for dev/testing to speed up destruction. Set to false for true Prod!
  skip_final_snapshot  = true 

  tags = {
    Environment = "production"
    Project     = "Vocal4Local"
  }
}

