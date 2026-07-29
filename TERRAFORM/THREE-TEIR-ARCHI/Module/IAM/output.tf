output "iam_role_name" {

  value = aws_iam_role.ssm_role.name

}

output "iam_role_arn" {

  value = aws_iam_role.ssm_role.arn

}

output "instance_profile_name" {

  value = aws_iam_instance_profile.ssm_profile.name

}

output "instance_profile_arn" {

  value = aws_iam_instance_profile.ssm_profile.arn

}
