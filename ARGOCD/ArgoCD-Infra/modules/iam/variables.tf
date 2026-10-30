variable "EKS_CLUSTER_ROLE_NAME" {
  description = "IAM role name for the EKS cluster"
  type        = string
}
variable "EKS_NODE_ROLE_NAME" {
  description = "IAM role name for EKS worker nodes"
  type        = string
}
variable "COMMON_TAGS" {
  description = "Common tags for IAM resources"
  type        = map(string)
}