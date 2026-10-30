
variable "EKS_CLUSTER_NAME" {
  description = "Name of the EKS cluster"
  type        = string
}
variable "EKS_CLUSTER_OIDC_ISSUER" {
  description = "OIDC issuer URL of the EKS cluster"
  type        = string
}
variable "EKS_CLUSTER_OIDC_PROVIDER_ARN" {
  description = "ARN of the IAM OIDC provider for the EKS cluster"
  type        = string
}
variable "ALB_CONTROLLER_ROLE_NAME" {
  description = "IAM role name for AWS Load Balancer Controller"
  type        = string
}
variable "ALB_CONTROLLER_CHART_VERSION" {
  description = "Helm chart version for AWS Load Balancer Controller"
  type        = string
}
variable "AWS_REGION" {
  description = "AWS region where the EKS cluster runs"
  type        = string
}
variable "VPC_ID" {
  description = "VPC ID used by the EKS cluster"
  type        = string
}
variable "COMMON_TAGS" {
  description = "Common tags for AWS resources"
  type        = map(string)
}
