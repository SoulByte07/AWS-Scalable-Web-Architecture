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
  password             = "SuperSecretPassword123!" # TODO: Use AWS Secrets Manager for production secrets!
  
  db_subnet_group_name   = aws_db_subnet_group.vocal4local_db_group.name
  vpc_security_group_ids = [var.db_security_group_id]

  # TODO: Skip final snapshot for dev/testing to speed up destruction. Set to false for true Prod!
  skip_final_snapshot  = true 

  tags = {
    Environment = "production"
    Project     = "Vocal4Local"
  }
}

