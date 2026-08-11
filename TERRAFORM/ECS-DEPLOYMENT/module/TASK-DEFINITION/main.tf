resource "aws_ecs_task_definition" "THIS-TASK-DEFINITION" {
  family                   = var.TASK_FAMILY
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu    = var.TASK_CPU
  memory = var.TASK_MEMORY
  execution_role_arn = var.EXECUTION_ROLE_ARN
  task_role_arn      = var.TASK_ROLE_ARN
  container_definitions = jsonencode([
    {
      name      = var.FRONTEND_CONTAINER_NAME
      image     = var.FRONTEND_IMAGE
      essential = true
      portMappings = [
        {
          containerPort = var.FRONTEND_CONTAINER_PORT
          hostPort      = var.FRONTEND_CONTAINER_PORT
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.LOG_GROUP_NAME
          awslogs-region        = var.REGION_NAME
          awslogs-stream-prefix = "frontend"
        }
      }
    },
    {
      name      = var.BACKEND_CONTAINER_NAME
      image     = var.BACKEND_IMAGE
      essential = true
      portMappings = [
        {
          containerPort = var.BACKEND_CONTAINER_PORT
          hostPort      = var.BACKEND_CONTAINER_PORT
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.LOG_GROUP_NAME
          awslogs-region        = var.REGION_NAME
          awslogs-stream-prefix = "backend"
        }
      }
    }
  ])
}
