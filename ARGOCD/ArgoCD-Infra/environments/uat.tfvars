
AWS_REGION = "ap-south-1"

COMMON_TAGS = {
  Project     = "EKS-Infrastructure"
  Environment = "uat"
  ManagedBy   = "Terraform"
}

# VPC
VPC_NAME = "uat-eks-vpc"
VPC_CIDR = "10.2.0.0/16"

PUBLIC_SUBNETS = {
  public_a = {
    NAME = "uat-eks-public-a"
    CIDR = "10.2.1.0/24"
    AZ   = "ap-south-1a"
  }
  public_b = {
    NAME = "uat-eks-public-b"
    CIDR = "10.2.2.0/24"
    AZ   = "ap-south-1b"
  }
}

PRIVATE_SUBNETS = {
  private_a = {
    NAME = "uat-eks-private-a"
    CIDR = "10.2.11.0/24"
    AZ   = "ap-south-1a"
  }
  private_b = {
    NAME = "uat-eks-private-b"
    CIDR = "10.2.12.0/24"
    AZ   = "ap-south-1b"
  }
}

NAT_SUBNET_KEY = "public_a"

# IAM
EKS_CLUSTER_ROLE_NAME = "uat-eks-cluster-role"
EKS_NODE_ROLE_NAME    = "uat-eks-node-role"

# EKS CLUSTER
EKS_CLUSTER_NAME    = "uat-eks-cluster"
EKS_CLUSTER_VERSION = "1.34"

# EKS NODE GROUP
EKS_NODE_GROUP_NAME = "uat-eks-workers"
NODE_INSTANCE_TYPES = ["t3.small"]
NODE_DESIRED_SIZE   = 1
NODE_MIN_SIZE       = 1
NODE_MAX_SIZE       = 1
NODE_DISK_SIZE      = 30

# ALB CONTROLLER
ALB_CONTROLLER_ROLE_NAME     = "uat-eks-alb-controller-role"
ALB_CONTROLLER_CHART_VERSION = "3.6.0"
