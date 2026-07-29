output "security_group_ids" {
  description = "IDs of all Security Groups"
  value       = aws_security_group.SG[*].id
}

output "security_group_names" {
  description = "Names of all Security Groups"
  value       = aws_security_group.SG[*].name
}

output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.SG[0].id
}

output "app_sg_id" {
  description = "Application Security Group ID"
  value       = aws_security_group.SG[1].id
}

output "db_sg_id" {
  description = "Database Security Group ID"
  value       = aws_security_group.SG[2].id
}