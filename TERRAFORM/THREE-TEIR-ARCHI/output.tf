# RDS Output
output "db_instance_id" {
  value = module.rds.db_instance_id
}
output "db_endpoint" {
  value = module.rds.db_instance_endpoint
}
output "db_address" {
  value = module.rds.db_instance_address
}
output "db_subnet_group" {
  value = module.rds.db_subnet_group_name
}
# ALB Output
output "alb_id" {
  value = module.alb.alb_id
}
output "alb_arn" {
  value = module.alb.alb_arn
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
output "alb_zone_id" {
  value = module.alb.alb_zone_id
}
output "target_group_arn" {
  value = module.alb.target_group_arn
}
output "listener_arn" {
  value = module.alb.listener_arn
}
# EC2 Output
output "instance_id" {
  value = module.ec2.instance_id
}
output "private_ip" {
  value = module.ec2.private_ip
}
output "availability_zone" {
  value = module.ec2.availability_zone
}
output "instance_state" {
  value = module.ec2.instance_state
}
output "key_name" {
  value = module.ec2.key_name
}
output "private_key_file" {
  value = module.ec2.private_key_file
}
# IAM Role for Session Manager
output "iam_role_name" {
  value = module.iam.iam_role_name
}
output "iam_role_arn" {
  value = module.iam.iam_role_arn
}
output "instance_profile_name" {
  value = module.iam.instance_profile_name
}
output "instance_profile_arn" {
  value = module.iam.instance_profile_arn
}