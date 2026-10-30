
variable "EKS_CLUSTER_NAME" {
  description = "Name of the EKS cluster"
  type        = string
}
variable "EKS_NODE_GROUP_NAME" {
  description = "Name of the managed EKS node group"
  type        = string
}
variable "EKS_NODE_ROLE_ARN" {
  description = "IAM role ARN for EKS worker nodes"
  type        = string
}
variable "PRIVATE_SUBNET_IDS" {
  description = "Private subnet IDs where worker nodes will run"
  type        = list(string)
}
variable "NODE_INSTANCE_TYPES" {
  description = "EC2 instance types for worker nodes"
  type        = list(string)
}
variable "NODE_DESIRED_SIZE" {
  description = "Desired number of worker nodes"
  type        = number
}
variable "NODE_MIN_SIZE" {
  description = "Minimum number of worker nodes"
  type        = number
}
variable "NODE_MAX_SIZE" {
  description = "Maximum number of worker nodes"
  type        = number
}
variable "NODE_DISK_SIZE" {
  description = "Root disk size in GB for each worker node"
  type        = number
}
variable "COMMON_TAGS" {
  description = "Common tags for node group resources"
  type        = map(string)
}
