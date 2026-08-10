output "security_group_ids" {
  description = "IDs of all Security Groups"
  value       = aws_security_group.this_SG[*].id
}
output "security_group_names" {
  description = "Names of all Security Groups"
  value       = aws_security_group.this_SG[*].name
}
output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.this_SG[0].id
}
output "app_sg_id" {
  description = "Application Security Group ID"
  value       = aws_security_group.this_SG[1].id
}
output "db_sg_id" {
  description = "Database Security Group ID"
  value       = aws_security_group.this_SG[2].id
}