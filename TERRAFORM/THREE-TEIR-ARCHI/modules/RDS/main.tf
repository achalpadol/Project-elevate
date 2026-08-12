# DB Subnet Group
resource "aws_db_subnet_group" "this_db_subnet_group" {
  name       = var.DB_SUBNET_GROUP_NAME
  subnet_ids = var.PRIVATE_DB_SUBNET_IDS
  tags = {
    Name = var.DB_SUBNET_GROUP_NAME
  }
}
# RDS Instance
resource "aws_db_instance" "this_rds" {
  identifier             = var.DB_IDENTIFIER
  engine                 = var.ENGINE
  engine_version         = var.ENGINE_VERSION
  instance_class         = var.INSTANCE_CLASS
  allocated_storage      = var.ALLOCATED_STORAGE
  storage_type           = var.STORAGE_TYPE
  db_name                = var.DB_NAME
  username               = var.USERNAME
  password               = var.PASSWORD
  db_subnet_group_name   = aws_db_subnet_group.this_db_subnet_group.name
  vpc_security_group_ids = [var.DB_SECURITY_GROUP_ID]
  publicly_accessible    = var.PUBLICLY_ACCESSIBLE
  skip_final_snapshot    = var.SKIP_FINAL_SNAPSHOT
  tags = merge(
    var.RDS_COMMON_TAGS, {
      Name = var.DB_NAME
  })
}
