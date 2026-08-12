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
