REGION_NAME          = "us-east-1"
VPC_CIDR             = "10.3.0.0/16"
ENABLE_DNS_SUPPORT   = true
ENABLE_DNS_HOSTNAMES = true
VPC_NAME             = "prod-vpc"
IGW_NAME             = "prod-igw"
# Public Subnets
PUBLIC_SUBNET_CIDRS = [
  "10.3.1.0/24",
  "10.3.2.0/24"
]
PUBLIC_SUBNET_AZS = [
  "us-east-1a",
  "us-east-1b"
]
PUBLIC_SUBNET_NAMES = [
  "prod-public-web-1a",
  "prod-public-web-1b"
]
MAP_PUBLIC_IP_ON_LAUNCH = true
# Private App Subnets
PRIVATE_APP_SUBNET_CIDRS = [
  "10.3.11.0/24",
  "10.3.12.0/24"
]
PRIVATE_APP_SUBNET_AZS = [
  "us-east-1a",
  "us-east-1b"
]
PRIVATE_APP_SUBNET_NAMES = [
  "prod-private-app-1a",
  "prod-private-app-1b"
]
# Private DB Subnets
PRIVATE_DB_SUBNET_CIDRS = [
  "10.3.21.0/24",
  "10.3.22.0/24"
]
PRIVATE_DB_SUBNET_AZS = [
  "us-east-1a",
  "us-east-1b"
]
PRIVATE_DB_SUBNET_NAMES = [
  "prod-private-db-1a",
  "prod-private-db-1b"
]
MY_ELASTIC_IP            = "prod-eip"
MY_NAT_GATEWAY           = "prod-nat"
PRIVATE_ROUTE_CIDR       = "0.0.0.0/0"
PRIVATE_ROUTE_TABLE_NAME = "prod-private-rt"
PUBLIC_ROUTE_CIDR        = "0.0.0.0/0"
PUBLIC_ROUTE_TABLE_NAME  = "prod-public-rt"
# Security Groups
SECURITY_GROUPS = {
  alb-sg = {
    ports = [80, 443]
  }
  app-sg = {
    ports = [80]
  }
  db-sg = {
    ports = [3306]
  }
}
COMMON_TAGS = {
  Environment = "Production"
  Project     = "Three_Tier_Project"
  Application = "Employee_Management_System"
  Owner       = "Cloud-Team"
  ManagedBy   = "Terraform"
}
# RDS
DB_SUBNET_GROUP_NAME = "prod-db-subnet-group"
DB_IDENTIFIER        = "prod-my-rds"
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
ALB_NAME                   = "prod-my-alb"
INTERNAL                   = false
LOAD_BALANCER_TYPE         = "application"
ENABLE_DELETION_PROTECTION = false
TARGET_GROUP_NAME          = "prod-my-target-group"
TARGET_GROUP_PORT          = 80
TARGET_GROUP_PROTOCOL      = "HTTP"
LISTENER_PORT              = 80
LISTENER_PROTOCOL          = "HTTP"
DEFAULT_ACTION_TYPE        = "forward"
HEALTH_CHECK_PATH          = "/"
# EC2
AMI_ID               = "ami-0b6d9d3d33ba97d99"
INSTANCE_TYPE        = "m7i-flex.large"
INSTANCE_NAME        = "prod-application-server"
KEY_NAME             = "terraform-key"
KEY_ALGORITHM        = "RSA"
RSA_BITS             = 4096
PRIVATE_KEY_FILENAME = "terraform-key.pem"
PUBLIC_KEY_PATH      = "/mnt/c/Users/admin/Downloads/"
# IAM
IAM_ROLE_NAME         = "Prod-EC2-SSM-Role"
INSTANCE_PROFILE_NAME = "Prod-EC2-SSM-Profile"
SSM_POLICY_ARN        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
EXECUTION_ROLE_NAME   = "prod-employee-execution-role"
TASK_ROLE_NAME        = "prod-employee-task-role"