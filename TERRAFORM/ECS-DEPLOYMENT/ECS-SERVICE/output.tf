output "service_id" {
  value = aws_ecs_service.this_service.id
}
output "service_name" {
  value = aws_ecs_service.this_service.name
}
output "service_arn" {
  value = aws_ecs_service.this_service.arn
}