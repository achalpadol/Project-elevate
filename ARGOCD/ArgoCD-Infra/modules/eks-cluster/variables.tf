
variable "EKS_CLUSTER_NAME" {
  description = "Name of the EKS cluster"
  type        = string
}
variable "EKS_CLUSTER_VERSION" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}
variable "EKS_CLUSTER_ROLE_ARN" {
  description = "IAM role ARN used by the EKS control plane"
  type        = string
}
variable "PRIVATE_SUBNET_IDS" {
  description = "Private subnet IDs for the EKS cluster"
  type        = list(string)
}
variable "PRIVATE_ENDPOINT_ACCESS" {
  description = "Allow access to the EKS API from within the VPC"
  type        = bool
  default     = true
}
variable "PUBLIC_ENDPOINT_ACCESS" {
  description = "Allow access to the EKS API through its public endpoint"
  type        = bool
  default     = true
}
variable "PUBLIC_ACCESS_CIDRS" {
  description = "CIDR ranges allowed to access the public EKS API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "COMMON_TAGS" {
  description = "Common tags for EKS resources"
  type        = map(string)
}
