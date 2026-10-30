AWS_REGION = "ap-south-1"

COMMON_TAGS = {
  Project     = "EKS-Infrastructure"
  Environment = "dev"
  ManagedBy   = "Terraform"
}
#vpc
VPC_NAME = "dev-eks-vpc"
VPC_CIDR = "10.0.0.0/16"
PUBLIC_SUBNETS = {
  public_a = {
    NAME = "dev-eks-public-a"
    CIDR = "10.0.1.0/24"
    AZ   = "ap-south-1a"
  }
  public_b = {
    NAME = "dev-eks-public-b"
    CIDR = "10.0.2.0/24"
    AZ   = "ap-south-1b"
  }
}
PRIVATE_SUBNETS = {
  private_a = {
    NAME = "dev-eks-private-a"
    CIDR = "10.0.11.0/24"
    AZ   = "ap-south-1a"
  }
  private_b = {
    NAME = "dev-eks-private-b"
    CIDR = "10.0.12.0/24"
    AZ   = "ap-south-1b"
  }
}
NAT_SUBNET_KEY = "public_a"
#IAM
EKS_CLUSTER_ROLE_NAME = "dev-eks-cluster-role"
EKS_NODE_ROLE_NAME    = "dev-eks-node-role"
#EKS-CLUSTER
EKS_CLUSTER_NAME    = "dev-eks-cluster"
EKS_CLUSTER_VERSION = "1.34"
#EKS-NODE-GROUP
EKS_NODE_GROUP_NAME = "dev-eks-workers"
NODE_INSTANCE_TYPES = ["t3.small"]
NODE_DESIRED_SIZE   = 1
NODE_MIN_SIZE       = 1
NODE_MAX_SIZE       = 2
NODE_DISK_SIZE      = 30
#ALB-Controller
ALB_CONTROLLER_ROLE_NAME     = "dev-eks-alb-controller-role"
ALB_CONTROLLER_CHART_VERSION = "3.6.0"
