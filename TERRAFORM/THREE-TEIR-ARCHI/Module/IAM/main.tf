# IAM Role for EC2
resource "aws_iam_role" "ssm_role" {
  name = var.iam_role_name
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
  tags = {
    Name = var.iam_role_name
  }
}
# Attach AmazonSSMManagedInstanceCore Policy
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = var.ssm_policy_arn
}
# Instance Profile
resource "aws_iam_instance_profile" "ssm_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.ssm_role.name
}