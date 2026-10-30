
variable "AWS_REGION" {
  description = "AWS region for EKS infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "ENVIRONMENT" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "PROJECT_NAME" {
  description = "Project name"
  type        = string
  default     = "EKS-Infrastructure"
}

variable "COMMON_TAGS" {
  description = "Common tags for AWS resources"
  type        = map(string)

  default = {
    Project   = "EKS-Infrastructure"
    ManagedBy = "Terraform"
  }
}
#VPC
variable "VPC_NAME" {
  description = "Name of the VPC"
  type        = string
}
variable "VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "PUBLIC_SUBNETS" {
  description = "Public subnet configuration"
  type = map(object({
    NAME = string
    CIDR = string
    AZ   = string
  }))
}
variable "PRIVATE_SUBNETS" {
  description = "Private subnet configuration"

  type = map(object({
    NAME = string
    CIDR = string
    AZ   = string
  }))
}
variable "NAT_SUBNET_KEY" {
  description = "Public subnet key for the NAT Gateway"
  type        = string
}
#IAM
variable "EKS_CLUSTER_ROLE_NAME" {
  description = "IAM role name for the EKS cluster"
  type        = string
}
variable "EKS_NODE_ROLE_NAME" {
  description = "IAM role name for EKS worker nodes"
  type        = string
}
#EKS-CLUSTER
variable "EKS_CLUSTER_NAME" {
  description = "Name of the EKS cluster"
  type        = string
}
variable "EKS_CLUSTER_VERSION" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}
# EKS-NODE-GROUP
variable "EKS_NODE_GROUP_NAME" {
  description = "Name of the EKS node group"
  type        = string
}
variable "NODE_INSTANCE_TYPES" {
  description = "EC2 instance types for EKS worker nodes"
  type        = list(string)
}
variable "NODE_DESIRED_SIZE" {
  description = "Desired worker node count"
  type        = number
}
variable "NODE_MIN_SIZE" {
  description = "Minimum worker node count"
  type        = number
}
variable "NODE_MAX_SIZE" {
  description = "Maximum worker node count"
  type        = number
}
variable "NODE_DISK_SIZE" {
  description = "Worker node root disk size in GB"
  type        = number
}
#ALB-CONTROLLER
variable "ALB_CONTROLLER_ROLE_NAME" {
  description = "IAM role name for AWS Load Balancer Controller"
  type        = string
}
variable "ALB_CONTROLLER_CHART_VERSION" {
  description = "Helm chart version for AWS Load Balancer Controller"
  type        = string
}



