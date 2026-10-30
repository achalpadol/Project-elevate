
AWS_REGION = "ap-south-1"

COMMON_TAGS = {
  Project     = "EKS-Infrastructure"
  Environment = "prod"
  ManagedBy   = "Terraform"
}

# VPC
VPC_NAME = "prod-eks-vpc"
VPC_CIDR = "10.3.0.0/16"

PUBLIC_SUBNETS = {
  public_a = {
    NAME = "prod-eks-public-a"
    CIDR = "10.3.1.0/24"
    AZ   = "ap-south-1a"
  }
  public_b = {
    NAME = "prod-eks-public-b"
    CIDR = "10.3.2.0/24"
    AZ   = "ap-south-1b"
  }
}

PRIVATE_SUBNETS = {
  private_a = {
    NAME = "prod-eks-private-a"
    CIDR = "10.3.11.0/24"
    AZ   = "ap-south-1a"
  }
  private_b = {
    NAME = "prod-eks-private-b"
    CIDR = "10.3.12.0/24"
    AZ   = "ap-south-1b"
  }
}

NAT_SUBNET_KEY = "public_a"

# IAM
EKS_CLUSTER_ROLE_NAME = "prod-eks-cluster-role"
EKS_NODE_ROLE_NAME    = "prod-eks-node-role"

# EKS CLUSTER
EKS_CLUSTER_NAME    = "prod-eks-cluster"
EKS_CLUSTER_VERSION = "1.34"

# EKS NODE GROUP
EKS_NODE_GROUP_NAME = "prod-eks-workers"
NODE_INSTANCE_TYPES = ["t3.medium"]
NODE_DESIRED_SIZE   = 1
NODE_MIN_SIZE       = 1
NODE_MAX_SIZE       = 2
NODE_DISK_SIZE      = 30

# ALB CONTROLLER
ALB_CONTROLLER_ROLE_NAME     = "prod-eks-alb-controller-role"
ALB_CONTROLLER_CHART_VERSION = "3.6.0"
