output "iam_role_name" {
  value = aws_iam_role.this_ssm_role.name
}
output "iam_role_arn" {
  value = aws_iam_role.this_ssm_role.arn
}
output "instance_profile_name" {
  value = aws_iam_instance_profile.this_ssm_profile.name
}
output "instance_profile_arn" {
  value = aws_iam_instance_profile.this_ssm_profile.arn
}
output "execution_role_arn" {
  value = aws_iam_role.this_ecs_execution_role.arn
}
output "task_role_arn" {
  value = aws_iam_role.this_ecs_task_role.arn
}
output "execution_role_name" {
  value = aws_iam_role.this_ecs_execution_role.name
}
output "task_role_name" {
  value = aws_iam_role.this_ecs_task_role.name
}