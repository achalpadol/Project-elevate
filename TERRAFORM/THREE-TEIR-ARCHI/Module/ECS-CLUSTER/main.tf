resource "aws_ecs_service" "this_service" {
  name                   = var.SERVICE_NAME
  cluster                = var.CLUSTER_ARN
  task_definition        = var.TASK_DEFINITION_ARN
  desired_count          = var.DESIRED_COUNT
  launch_type            = "FARGATE"
  platform_version       = "LATEST"
  enable_execute_command = true
  network_configuration {
    subnets          = var.PRIVATE_SUBNET_IDS
    security_groups  = var.SECURITY_GROUP_IDS
    assign_public_ip = false
  }
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  tags = {
    Name = var.CLUSTER_NAME
  }
  load_balancer {
    target_group_arn = var.TARGET_GROUP_ARN
    container_name   = var.FRONTEND_CONTAINER_NAME
    container_port   = var.FRONTEND_CONTAINER_PORT
  }
}

