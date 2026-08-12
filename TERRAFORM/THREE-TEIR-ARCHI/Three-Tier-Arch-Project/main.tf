# VPC Module
module "vpc" {
  source = "./modules/VPC"
  # VPC
  VPC_CIDR             = var.VPC_CIDR
  ENABLE_DNS_SUPPORT   = var.ENABLE_DNS_SUPPORT
  ENABLE_DNS_HOSTNAMES = var.ENABLE_DNS_HOSTNAMES
  VPC_NAME             = var.VPC_NAME
  IGW_NAME             = var.IGW_NAME
  REGION_NAME          = var.REGION_NAME
  VPC_COMMON_TAGS      = var.COMMON_TAGS
  # Public Subnets
  PUBLIC_SUBNET_CIDRS     = var.PUBLIC_SUBNET_CIDRS
  PUBLIC_SUBNET_AZS       = var.PUBLIC_SUBNET_AZS
  PUBLIC_SUBNET_NAMES     = var.PUBLIC_SUBNET_NAMES
  MAP_PUBLIC_IP_ON_LAUNCH = var.MAP_PUBLIC_IP_ON_LAUNCH
  # Private Application Subnets
  PRIVATE_APP_SUBNET_CIDRS = var.PRIVATE_APP_SUBNET_CIDRS
  PRIVATE_APP_SUBNET_AZS   = var.PRIVATE_APP_SUBNET_AZS
  PRIVATE_APP_SUBNET_NAMES = var.PRIVATE_APP_SUBNET_NAMES
  # Private Database Subnets
  PRIVATE_DB_SUBNET_CIDRS = var.PRIVATE_DB_SUBNET_CIDRS
  PRIVATE_DB_SUBNET_AZS   = var.PRIVATE_DB_SUBNET_AZS
  PRIVATE_DB_SUBNET_NAMES = var.PRIVATE_DB_SUBNET_NAMES
  # NAT Gateway
  MY_ELASTIC_IP  = var.MY_ELASTIC_IP
  MY_NAT_GATEWAY = var.MY_NAT_GATEWAY
  # Route Tables
  PRIVATE_ROUTE_CIDR       = var.PRIVATE_ROUTE_CIDR
  PRIVATE_ROUTE_TABLE_NAME = var.PRIVATE_ROUTE_TABLE_NAME
  PUBLIC_ROUTE_CIDR        = var.PUBLIC_ROUTE_CIDR
  PUBLIC_ROUTE_TABLE_NAME  = var.PUBLIC_ROUTE_TABLE_NAME
}
# Security Group Module
module "security_group" {
  source = "./modules/SG"
  VPC_ID          = module.vpc.vpc_id
  SECURITY_GROUPS = var.SECURITY_GROUPS
}
# RDS Module
module "rds" {
  source = "./modules/RDS"
  DB_SUBNET_GROUP_NAME  = var.DB_SUBNET_GROUP_NAME
  PRIVATE_DB_SUBNET_IDS = module.vpc.private_db_subnet_ids
  DB_SECURITY_GROUP_ID  = module.security_group.db_sg_id
  DB_IDENTIFIER         = var.DB_IDENTIFIER
  ENGINE                = var.ENGINE
  ENGINE_VERSION        = var.ENGINE_VERSION
  INSTANCE_CLASS        = var.INSTANCE_CLASS
  ALLOCATED_STORAGE     = var.ALLOCATED_STORAGE
  STORAGE_TYPE          = var.STORAGE_TYPE
  DB_NAME               = var.DB_NAME
  USERNAME              = var.USERNAME
  PASSWORD              = var.PASSWORD
  PUBLICLY_ACCESSIBLE   = var.PUBLICLY_ACCESSIBLE
  SKIP_FINAL_SNAPSHOT   = var.SKIP_FINAL_SNAPSHOT
  RDS_COMMON_TAGS       = var.COMMON_TAGS
}
# EC2 Module
module "ec2" {
  source = "./modules/EC2"
  AMI_ID                = var.AMI_ID
  INSTANCE_TYPE         = var.INSTANCE_TYPE
  INSTANCE_NAME         = var.INSTANCE_NAME
  PRIVATE_APP_SUBNET_ID = module.vpc.private_app_subnet_ids[0]
  APP_SECURITY_GROUP_ID = module.security_group.app_sg_id
  IAM_INSTANCE_PROFILE  = module.iam.instance_profile_name
  PUBLIC_KEY_PATH       = var.PUBLIC_KEY_PATH
  KEY_NAME              = var.KEY_NAME
  KEY_ALGORITHM         = var.KEY_ALGORITHM
  RSA_BITS              = var.RSA_BITS
  PRIVATE_KEY_FILENAME  = var.PRIVATE_KEY_FILENAME
  APP_COMMON_TAGS       = var.COMMON_TAGS
}
# IAM Module
module "iam" {
  source = "./modules/IAM"
  IAM_ROLE_NAME         = var.IAM_ROLE_NAME
  INSTANCE_PROFILE_NAME = var.INSTANCE_NAME
  SSM_POLICY_ARN        = var.SSM_POLICY_ARN
  IAM_COMMON_TAGS       = var.COMMON_TAGS
}
# ALB Module
module "alb" {
  source = "./modules/ALB"
  ALB_NAME                   = var.ALB_NAME
  INTERNAL                   = var.INTERNAL
  LOAD_BALANCER_TYPE         = var.LOAD_BALANCER_TYPE
  ALB_SECURITY_GROUP_ID      = module.security_group.alb_sg_id
  PUBLIC_SUBNET_IDS          = module.vpc.public_subnet_ids
  ENABLE_DELETION_PROTECTION = var.ENABLE_DELETION_PROTECTION
  VPC_ID                     = module.vpc.vpc_id
  TARGET_GROUP_NAME          = var.TARGET_GROUP_NAME
  TARGET_GROUP_PORT          = var.TARGET_GROUP_PORT
  TARGET_GROUP_PROTOCOL      = var.TARGET_GROUP_PROTOCOL
  HEALTH_CHECK_PATH          = var.HEALTH_CHECK_PATH
  LISTENER_PORT              = var.LISTENER_PORT
  LISTENER_PROTOCOL          = var.LISTENER_PROTOCOL
  DEFAULT_ACTION_TYPE        = var.DEFAULT_ACTION_TYPE
  INSTANCE_ID                = module.ec2.instance_id
  ALB_COMMON_TAGS            = var.COMMON_TAGS

}