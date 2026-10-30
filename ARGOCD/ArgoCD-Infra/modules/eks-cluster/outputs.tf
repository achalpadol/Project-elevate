
output "EKS_CLUSTER_NAME" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.this_eks_cluster.name
}
output "EKS_CLUSTER_ARN" {
  description = "ARN of the EKS cluster"
  value       = aws_eks_cluster.this_eks_cluster.arn
}
output "EKS_CLUSTER_ENDPOINT" {
  description = "API endpoint of the EKS cluster"
  value       = aws_eks_cluster.this_eks_cluster.endpoint
}
output "EKS_CLUSTER_CERTIFICATE_AUTHORITY_DATA" {
  description = "Certificate authority data for the EKS cluster"
  value       = aws_eks_cluster.this_eks_cluster.certificate_authority[0].data
}
output "EKS_CLUSTER_OIDC_ISSUER" {
  description = "OIDC issuer URL of the EKS cluster"
  value       = aws_eks_cluster.this_eks_cluster.identity[0].oidc[0].issuer
}
output "EKS_CLUSTER_OIDC_PROVIDER_ARN" {
  description = "ARN of the IAM OIDC provider"
  value       = aws_iam_openid_connect_provider.this_oidc_provider.arn
}
