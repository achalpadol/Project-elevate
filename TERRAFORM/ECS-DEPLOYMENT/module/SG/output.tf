output "security_group_ids" {
  description = "IDs of all Security Groups"
  value       = { for key, sg in aws_security_group.this_sg : key => sg.id }
}
output "security_group_names" {
  description = "Names of all Security Groups"
  value       = { for key, sg in aws_security_group.this_sg : key => sg.name }
}

output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.this_sg["alb-sg"].id
}

output "app_sg_id" {
  description = "Application Security Group ID"
  value       = aws_security_group.this_sg["app-sg"].id
}

output "db_sg_id" {
  description = "Database Security Group ID"
  value       = aws_security_group.this_sg["db-sg"].id
}