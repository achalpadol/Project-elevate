
resource "aws_eks_node_group" "this_node_group" {
  cluster_name    = var.EKS_CLUSTER_NAME
  node_group_name = var.EKS_NODE_GROUP_NAME
  node_role_arn   = var.EKS_NODE_ROLE_ARN
  subnet_ids      = var.PRIVATE_SUBNET_IDS

  instance_types = var.NODE_INSTANCE_TYPES
  capacity_type  = "ON_DEMAND"
  disk_size      = var.NODE_DISK_SIZE

  scaling_config {
    desired_size = var.NODE_DESIRED_SIZE
    min_size     = var.NODE_MIN_SIZE
    max_size     = var.NODE_MAX_SIZE
  }

  update_config {
    max_unavailable = 1
  }

  tags = merge(var.COMMON_TAGS, {
    Name = var.EKS_NODE_GROUP_NAME
  })
}
