REGION_NAME          = "us-east-1"
VPC_CIDR             = "10.2.0.0/16"
ENABLE_DNS_SUPPORT   = true
ENABLE_DNS_HOSTNAMES = true
VPC_NAME             = "uat-vpc"
IGW_NAME             = "uat-igw"

PUBLIC_SUBNET_CIDRS = [
  "10.2.1.0/24",
  "10.2.2.0/24"
]

PUBLIC_SUBNET_AZS = [
  "us-east-1a",
  "us-east-1b"
]

PUBLIC_SUBNET_NAMES = [
  "uat-public-web-1a",
  "uat-public-web-1b"
]

MAP_PUBLIC_IP_ON_LAUNCH = true

PRIVATE_APP_SUBNET_CIDRS = [
  "10.2.11.0/24",
  "10.2.12.0/24"
]

PRIVATE_APP_SUBNET_AZS = [
  "us-east-1a",
  "us-east-1b"
]

PRIVATE_APP_SUBNET_NAMES = [
  "uat-private-app-1a",
  "uat-private-app-1b"
]

PRIVATE_DB_SUBNET_CIDRS = [
  "10.2.21.0/24",
  "10.2.22.0/24"
]

PRIVATE_DB_SUBNET_AZS = [
  "us-east-1a",
  "us-east-1b"
]

PRIVATE_DB_SUBNET_NAMES = [
  "uat-private-db-1a",
  "uat-private-db-1b"
]

MY_ELASTIC_IP            = "uat-eip"
MY_NAT_GATEWAY           = "uat-nat"
PRIVATE_ROUTE_CIDR       = "0.0.0.0/0"
PRIVATE_ROUTE_TABLE_NAME = "uat-private-rt"
PUBLIC_ROUTE_CIDR        = "0.0.0.0/0"
PUBLIC_ROUTE_TABLE_NAME  = "uat-public-rt"

SG_NAME = [
  "uat-alb-sg",
  "uat-app-sg",
  "uat-db-sg"
]

ALB_PORTS = [80, 443]
APP_PORTS = [80]
DB_PORTS  = [3306]

ALB_INGRESS_CIDR = ["0.0.0.0/0"]
EGRESS_CIDR       = ["0.0.0.0/0"]

EGRESS_FROM_PORT = 0
EGRESS_TO_PORT   = 0
EGRESS_PROTOCOL  = "-1"
INGRESS_PROTOCOL = "tcp"

# RDS
DB_SUBNET_GROUP_NAME = "uat-db-subnet-group"
DB_IDENTIFIER        = "uat-my-rds"
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
ALB_NAME                   = "uat-my-alb"
INTERNAL                   = false
LOAD_BALANCER_TYPE         = "application"
ENABLE_DELETION_PROTECTION = false
TARGET_GROUP_NAME          = "uat-my-target-group"
TARGET_GROUP_PORT          = 80
TARGET_GROUP_PROTOCOL      = "HTTP"
LISTENER_PORT              = 80
LISTENER_PROTOCOL          = "HTTP"
DEFAULT_ACTION_TYPE        = "forward"
HEALTH_CHECK_PATH          = "/"

# IAM
IAM_ROLE_NAME         = "UAT-EC2-SSM-Role"
EXECUTION_ROLE_NAME   = "uat-employee-execution-role"
TASK_ROLE_NAME        = "uat-employee-task-role"

# ECS
CLUSTER_NAME       = "uat-employee-management-cluster"
CONTAINER_INSIGHTS = "enabled"

TASK_FAMILY             = "uat-employee-management"
TASK_CPU                = 512
TASK_MEMORY             = 1024
FRONTEND_CONTAINER_NAME = "frontend"
FRONTEND_IMAGE          = "public.ecr.aws/v4c7w1f2/full-stack-repo:frontend-v1"
FRONTEND_CONTAINER_PORT = 80
BACKEND_CONTAINER_NAME  = "backend"
BACKEND_IMAGE           = "public.ecr.aws/v4c7w1f2/full-stack-repo:backend1"
BACKEND_CONTAINER_PORT  = 8080
LOG_GROUP_NAME          = "/ecs/uat-employee-cluster"

SERVICE_NAME  = "uat-employee-management-service"
DESIRED_COUNT = 1
