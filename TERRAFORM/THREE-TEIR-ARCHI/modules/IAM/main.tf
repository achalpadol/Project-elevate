# IAM Role for EC2
resource "aws_iam_role" "this_ssm_role" {
  name = var.IAM_ROLE_NAME
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = merge(
    var.IAM_COMMON_TAGS, {
      Name = var.IAM_ROLE_NAME
  })
}
# Attach AmazonSSMManagedInstanceCore Policy
resource "aws_iam_role_policy_attachment" "this_ssm_policy" {
  role       = aws_iam_role.this_ssm_role.name
  policy_arn = var.SSM_POLICY_ARN
}
# Instance Profile
resource "aws_iam_instance_profile" "this_ssm_profile" {
  name = var.INSTANCE_PROFILE_NAME
  role = aws_iam_role.this_ssm_role.name
}
