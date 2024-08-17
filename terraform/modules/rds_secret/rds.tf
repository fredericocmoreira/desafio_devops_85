resource "aws_db_instance" "devops_rds" {
  allocated_storage      = 10
  db_name                = "devops_rds"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.medium"
  username               = var.username_secret
  password               = var.password_secret
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.devops_db_subnet_group.name

  tags = {
    Name = "DevOps-RDS"
  }
}

resource "aws_db_subnet_group" "devops_db_subnet_group" {
  name       = "devops-db-subnet-group"
  subnet_ids = [var.private_subnet_rds_1a, var.private_subnet_rds_1b]

  tags = {
    Name = "DevOps DB Subnet Group"
  }
}