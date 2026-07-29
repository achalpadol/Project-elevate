output "db_instance_id" {
  value = aws_db_instance.rds.id
}

output "db_instance_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "db_instance_address" {
  value = aws_db_instance.rds.address
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}