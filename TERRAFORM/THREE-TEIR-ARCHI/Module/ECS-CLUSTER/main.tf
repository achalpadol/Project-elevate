resource "aws_ecs_cluster" "this_cluster" {
  name = var.CLUSTER_NAME
  setting {
    name  = "containerInsights"
    value = var.CONTAINER_INSIGHTS
  }
  tags = {
    Name = var.CLUSTER_NAME
  }
}