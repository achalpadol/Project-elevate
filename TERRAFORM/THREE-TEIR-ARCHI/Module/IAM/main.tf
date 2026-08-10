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
  tags = {
    Name = var.IAM_ROLE_NAME
  }
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
# ECS Task Execution Role
resource "aws_iam_role" "this_ecs_execution_role" {
  name = var.EXECUTION_ROLE_NAME
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
# ECS Task Role
resource "aws_iam_role" "this_ecs_task_role" {
  name = var.TASK_ROLE_NAME
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
# ECS Execution Policy
resource "aws_iam_role_policy_attachment" "this_execution_policy" {
  role       = aws_iam_role.this_ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
# CloudWatch Full Access
resource "aws_iam_role_policy_attachment" "this_cloudwatch" {
  role       = aws_iam_role.this_ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
# Amazon ECR Read Only
resource "aws_iam_role_policy_attachment" "this_ecr" {
  role       = aws_iam_role.this_ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}