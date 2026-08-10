REGION_NAME          = "us-east-1"
VPC_CIDR             = "10.0.0.0/16"
ENABLE_DNS_SUPPORT   = true
ENABLE_DNS_HOSTNAMES = true
VPC_NAME             = "dev-vpc"
IGW_NAME             = "dev-igw"
# Public Subnets
PUBLIC_SUBNET_CIDRS = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]
PUBLIC_SUBNET_AZS = [
  "us-east-1a",
  "us-east-1b"
]
PUBLIC_SUBNET_NAMES = [
  "dev-public-web-1a",
  "dev-public-web-1b"
]
MAP_PUBLIC_IP_ON_LAUNCH = true
# Private App Subnets
PRIVATE_APP_SUBNET_CIDRS = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]
PRIVATE_APP_SUBNET_AZS = [
  "us-east-1a",
  "us-east-1b"
]
PRIVATE_APP_SUBNET_NAMES = [
  "dev-private-app-1a",
  "dev-private-app-1b"
]
# Private DB Subnets
PRIVATE_DB_SUBNET_CIDRS = [
  "10.0.21.0/24",
  "10.0.22.0/24"
]
PRIVATE_DB_SUBNET_AZS = [
  "us-east-1a",
  "us-east-1b"
]
PRIVATE_DB_SUBNET_NAMES = [
  "dev-private-db-1a",
  "dev-private-db-1b"
]
MY_ELASTIC_IP            = "dev-eip"
MY_NAT_GATEWAY           = "dev-nat"
PRIVATE_ROUTE_CIDR       = "0.0.0.0/0"
PRIVATE_ROUTE_TABLE_NAME = "dev-private-rt"
PUBLIC_ROUTE_CIDR        = "0.0.0.0/0"
PUBLIC_ROUTE_TABLE_NAME  = "dev-public-rt"
# Security Groups
SG_NAME = [
  "dev-alb-sg",
  "dev-app-sg",
  "dev-db-sg"
]
ALB_PORTS = [80, 443]
APP_PORTS = [80]
DB_PORTS  = [3306]
ALB_INGRESS_CIDR = [
  "0.0.0.0/0"
]
EGRESS_CIDR = ["0.0.0.0/0"]
EGRESS_FROM_PORT = 0
EGRESS_TO_PORT   = 0
EGRESS_PROTOCOL  = "-1"
INGRESS_PROTOCOL = "tcp"
# RDS
DB_SUBNET_GROUP_NAME = "dev-db-subnet-group"
DB_IDENTIFIER        = "dev-my-rds"
ENGINE               = "mysql"
ENGINE_VERSION       = "8.0"
INSTANCE_CLASS       = "db.t3.micro"
ALLOCATED_STORAGE    = 20
STORAGE_TYPE         = "gp2"
DB_NAME              = "mydatabase"
USERNAME             = "admin"
PASSWORD             = "Admin12345"
PUBLICLY_ACCESSIBLE  = false
SKIP_FINAL_SNAPSHOT  = true
# ALB
ALB_NAME                   = "dev-my-alb"
INTERNAL                   = false
LOAD_BALANCER_TYPE         = "application"
ENABLE_DELETION_PROTECTION = false
TARGET_GROUP_NAME          = "dev-my-target-group"
TARGET_GROUP_PORT          = 80
TARGET_GROUP_PROTOCOL      = "HTTP"
LISTENER_PORT              = 80
LISTENER_PROTOCOL          = "HTTP"
DEFAULT_ACTION_TYPE        = "forward"
HEALTH_CHECK_PATH          = "/"
# EC2
AMI_ID               = "ami-0b6d9d3d33ba97d99"
INSTANCE_TYPE        = "m7i-flex.large"
INSTANCE_NAME        = "dev-application-server"
KEY_NAME             = "terraform-key"
KEY_ALGORITHM        = "RSA"
RSA_BITS             = 4096
PRIVATE_KEY_FILENAME = "terraform-key.pem"
PUBLIC_KEY_PATH      = "/mnt/c/Users/admin/Downloads/"
# IAM
IAM_ROLE_NAME         = "Dev-EC2-SSM-Role"
INSTANCE_PROFILE_NAME = "Dev-EC2-SSM-Profile"
SSM_POLICY_ARN        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
EXECUTION_ROLE_NAME   = "dev-employee-execution-role"
TASK_ROLE_NAME        = "dev-employee-task-role"
# ECS Cluster
CLUSTER_NAME       = "dev-employee-management-cluster"
CONTAINER_INSIGHTS = "enabled"
# ECS Task Definition
TASK_FAMILY             = "dev-employee-management"
TASK_CPU                = 512
TASK_MEMORY             = 1024
FRONTEND_CONTAINER_NAME = "frontend"
FRONTEND_IMAGE          = "public.ecr.aws/v4c7w1f2/full-stack-repo:frontend-v1"
FRONTEND_CONTAINER_PORT = 80
BACKEND_CONTAINER_NAME  = "backend"
BACKEND_IMAGE           = "public.ecr.aws/v4c7w1f2/full-stack-repo:backend1"
BACKEND_CONTAINER_PORT  = 8080
LOG_GROUP_NAME          = "/ecs/dev-employee-cluster"
# ECS Service
SERVICE_NAME  = "dev-employee-management-service"
DESIRED_COUNT = 1
