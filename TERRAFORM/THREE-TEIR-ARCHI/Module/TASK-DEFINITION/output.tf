output "task_definition_arn" {
  value = aws_ecs_task_definition.THIS-TASK-DEFINITION.arn
}
output "task_definition_family" {
  value = aws_ecs_task_definition.THIS-TASK-DEFINITION.family
}
output "task_definition_revision" {
  value = aws_ecs_task_definition.THIS-TASK-DEFINITION.revision
}