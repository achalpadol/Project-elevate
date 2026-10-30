
output "EKS_NODE_GROUP_NAME" {
  description = "Name of the managed EKS node group"
  value       = aws_eks_node_group.this_node_group.node_group_name
}
output "EKS_NODE_GROUP_ARN" {
  description = "ARN of the managed EKS node group"
  value       = aws_eks_node_group.this_node_group.arn
}
output "EKS_NODE_GROUP_STATUS" {
  description = "Current status of the managed EKS node group"
  value       = aws_eks_node_group.this_node_group.status
}
