# DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {

  name       = var.db_subnet_group_name
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = var.db_subnet_group_name
  }
}

# RDS Instance
resource "aws_db_instance" "rds" {

  identifier = var.db_identifier

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  db_name  = var.db_name
  username = var.username
  password = var.password

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [var.db_security_group_id]
  publicly_accessible = var.publicly_accessible
  skip_final_snapshot = var.skip_final_snapshot
  tags = {
    Name = var.db_identifier
  }
}