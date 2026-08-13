
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
tags = merge(
    var.IAM_COMMON_TAGS, {
      Name = var.EXECUTION_ROLE_NAME
    }
  )
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
 tags = merge(
    var.IAM_COMMON_TAGS, {
      Name = var.TASK_ROLE_NAME
    }
  )
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