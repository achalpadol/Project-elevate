
output "EKS_CLUSTER_ROLE_ARN" {
  description = "ARN of the EKS cluster IAM role"
  value       = aws_iam_role.this_eks_cluster_role.arn
}
output "EKS_CLUSTER_ROLE_NAME" {
  description = "Name of the EKS cluster IAM role"
  value       = aws_iam_role.this_eks_cluster_role.name
}
output "EKS_NODE_ROLE_ARN" {
  description = "ARN of the EKS worker node IAM role"
  value       = aws_iam_role.this_eks_node_role.arn
}
output "EKS_NODE_ROLE_NAME" {
  description = "Name of the EKS worker node IAM role"
  value       = aws_iam_role.this_eks_node_role.name
}
