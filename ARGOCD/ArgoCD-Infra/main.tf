
module "vpc" {
  source          = "./modules/vpc"
  VPC_NAME        = var.VPC_NAME
  VPC_CIDR        = var.VPC_CIDR
  PUBLIC_SUBNETS  = var.PUBLIC_SUBNETS
  PRIVATE_SUBNETS = var.PRIVATE_SUBNETS
  NAT_SUBNET_KEY  = var.NAT_SUBNET_KEY
  COMMON_TAGS     = var.COMMON_TAGS
}
#IAM
module "iam" {
  source                = "./modules/iam"
  EKS_CLUSTER_ROLE_NAME = var.EKS_CLUSTER_ROLE_NAME
  EKS_NODE_ROLE_NAME    = var.EKS_NODE_ROLE_NAME
  COMMON_TAGS           = var.COMMON_TAGS
}
#EKS-CLUSTER
module "eks_cluster" {
  source                  = "./modules/eks-cluster"
  EKS_CLUSTER_NAME        = var.EKS_CLUSTER_NAME
  EKS_CLUSTER_VERSION     = var.EKS_CLUSTER_VERSION
  EKS_CLUSTER_ROLE_ARN    = module.iam.EKS_CLUSTER_ROLE_ARN
  PRIVATE_SUBNET_IDS      = values(module.vpc.PRIVATE_SUBNET_IDS)
  PRIVATE_ENDPOINT_ACCESS = true
  PUBLIC_ENDPOINT_ACCESS  = true

  # Replace this with your own public IP /32 for better security.
  PUBLIC_ACCESS_CIDRS = ["0.0.0.0/0"]
  COMMON_TAGS         = var.COMMON_TAGS
  depends_on          = [module.iam]
}
#NODE-GROUP-MODULE
module "eks_node_group" {
  source              = "./modules/eks-node-group"
  EKS_CLUSTER_NAME    = module.eks_cluster.EKS_CLUSTER_NAME
  EKS_NODE_GROUP_NAME = var.EKS_NODE_GROUP_NAME
  EKS_NODE_ROLE_ARN   = module.iam.EKS_NODE_ROLE_ARN

  PRIVATE_SUBNET_IDS = values(module.vpc.PRIVATE_SUBNET_IDS)

  NODE_INSTANCE_TYPES = var.NODE_INSTANCE_TYPES
  NODE_DESIRED_SIZE   = var.NODE_DESIRED_SIZE
  NODE_MIN_SIZE       = var.NODE_MIN_SIZE
  NODE_MAX_SIZE       = var.NODE_MAX_SIZE
  NODE_DISK_SIZE      = var.NODE_DISK_SIZE

  COMMON_TAGS = var.COMMON_TAGS

  depends_on = [
    module.eks_cluster,
    module.iam
  ]
}
#ALB-Controller
module "alb_controller" {
  source           = "./modules/alb-controller"
  EKS_CLUSTER_NAME = module.eks_cluster.EKS_CLUSTER_NAME
  EKS_CLUSTER_OIDC_ISSUER = (
    module.eks_cluster.EKS_CLUSTER_OIDC_ISSUER
  )
  EKS_CLUSTER_OIDC_PROVIDER_ARN = (
    module.eks_cluster.EKS_CLUSTER_OIDC_PROVIDER_ARN
  )
  ALB_CONTROLLER_ROLE_NAME     = var.ALB_CONTROLLER_ROLE_NAME
  ALB_CONTROLLER_CHART_VERSION = var.ALB_CONTROLLER_CHART_VERSION

  AWS_REGION = var.AWS_REGION
  VPC_ID     = module.vpc.VPC_ID

  COMMON_TAGS = var.COMMON_TAGS

  depends_on = [
    module.eks_cluster,
    module.eks_node_group
  ]
}


