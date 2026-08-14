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
# alb output
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
#  IAM role 
output "execution_role_arn" {
  description = "ARN of the ECS Task Execution Role"
  value       = aws_iam_role.this_ecs_execution_role.arn
}
output "execution_role_name" {
  description = "Name of the ECS Task Execution Role"
  value       = aws_iam_role.this_ecs_execution_role.name
}
output "task_role_arn" {
  description = "ARN of the ECS Task Role"
  value       = aws_iam_role.this_ecs_task_role.arn
}
output "task_role_name" {
  description = "Name of the ECS Task Role"
  value       = aws_iam_role.this_ecs_task_role.name
}
#ECS-Cluster
output "ecs_cluster_name" {
  value = module.ecs_cluster.cluster_name
}
output "ecs_cluster_arn" {
  value = module.ecs_cluster.cluster_arn
}
#ECS-Task_definition
output "task_definition_arn" {
  value = module.ecs_task_definition.task_definition_arn
}
output "task_definition_family" {
  value = module.ecs_task_definition.task_definition_family
}
output "task_definition_revision" {
  value = module.ecs_task_definition.task_definition_revision
}
#ECS Service
output "ecs_service_name" {
  value = module.ecs_service.service_name
}
output "ecs_service_arn" {
  value = module.ecs_service.service_arn
}
