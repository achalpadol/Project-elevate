# VPC
variable "VPC_CIDR" {
  description = "VPC CIDR Block"
  type        = string
}
variable "REGION_NAME" {
  type = string
}
variable "ENABLE_DNS_SUPPORT" {
  description = "Enable DNS Support"
  type        = bool
}
variable "ENABLE_DNS_HOSTNAMES" {
  description = "Enable DNS Hostnames"
  type        = bool
}
variable "VPC_NAME" {
  description = "VPC Name"
  type        = string
}
variable "IGW_NAME" {
  type = string
}
# Public Subnets
variable "PUBLIC_SUBNET_CIDRS" {
  description = "Public subnet CIDRs"
  type        = list(string)
}
variable "PUBLIC_SUBNET_AZS" {
  description = "Public subnet AZs"
  type        = list(string)
}
variable "PUBLIC_SUBNET_NAMES" {
  description = "Public subnet names"
  type        = list(string)
}
variable "MAP_PUBLIC_IP_ON_LAUNCH" {
  description = "Assign public IP automatically"
  type        = bool
}
# Private App Subnets
variable "PRIVATE_APP_SUBNET_CIDRS" {
  description = "Application subnet CIDRs"
  type        = list(string)
}
variable "PRIVATE_APP_SUBNET_AZS" {
  type = list(string)
}
variable "PRIVATE_APP_SUBNET_NAMES" {
  description = "Application subnet names"
  type        = list(string)
}
# Private DB Subnets
variable "PRIVATE_DB_SUBNET_CIDRS" {
  description = "Database subnet CIDRs"
  type        = list(string)
}
variable "PRIVATE_DB_SUBNET_AZS" {
  description = "Database subnet AZs"
  type        = list(string)
}
variable "PRIVATE_DB_SUBNET_NAMES" {
  description = "Database subnet names"
  type        = list(string)
}
# Security Group Variables
variable "SG_NAME" {
  type = list(string)
}
variable "ALB_PORTS" {
  type = list(number)
}
variable "APP_PORTS" {
  type = list(number)
}
variable "DB_PORTS" {
  type = list(number)
}
variable "ALB_INGRESS_CIDR" {
  description = "CIDR block allowed to access ALB"
  type        = list(string)
}
variable "EGRESS_CIDR" {
  description = "CIDR block for outbound traffic"
  type        = list(string)
}
variable "EGRESS_FROM_PORT" {
  description = "Starting outbound port"
  type        = number
}
variable "EGRESS_TO_PORT" {
  description = "Ending outbound port"
  type        = number
}
variable "EGRESS_PROTOCOL" {
  description = "Protocol for outbound traffic"
  type        = string
}
variable "INGRESS_PROTOCOL" {
  description = "Protocol used for ingress rules"
  type        = string
}
variable "MY_ELASTIC_IP" {
  type = string
}
variable "MY_NAT_GATEWAY" {
  type = string
}
variable "PRIVATE_ROUTE_CIDR" {
  description = "Destination CIDR for the private route"
  type        = string
}
variable "PRIVATE_ROUTE_TABLE_NAME" {
  description = "Private Route Table Name"
  type        = string
}
variable "PUBLIC_ROUTE_CIDR" {
  description = "Destination CIDR for Public Route Table"
  type        = string
}
variable "PUBLIC_ROUTE_TABLE_NAME" {
  description = "Public Route Table Name"
  type        = string
}
# RDS Variables
variable "DB_SUBNET_GROUP_NAME" {
  type = string
}
variable "DB_IDENTIFIER" {
  type = string
}
variable "ENGINE" {
  type = string
}
variable "ENGINE_VERSION" {
  type = string
}
variable "INSTANCE_CLASS" {
  type = string
}
variable "ALLOCATED_STORAGE" {
  type = number
}
variable "STORAGE_TYPE" {
  type = string
}
variable "DB_NAME" {
  type = string
}
variable "USERNAME" {
  type = string
}
variable "PASSWORD" {
  type      = string
  sensitive = true
}
variable "PUBLICLY_ACCESSIBLE" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
}
variable "SKIP_FINAL_SNAPSHOT" {
  description = "Skip final snapshot when deleting the RDS instance"
  type        = bool
}
# ALB Variables
variable "ALB_NAME" {
  type = string
}
variable "TARGET_GROUP_NAME" {
  type = string
}
variable "TARGET_GROUP_PORT" {
  type = number
}
variable "TARGET_GROUP_PROTOCOL" {
  description = "Target Group Protocol"
  type        = string
}
variable "HEALTH_CHECK_PATH" {
  description = "Health Check Path"
  type        = string
}
variable "LISTENER_PORT" {
  type = number
}
variable "LISTENER_PROTOCOL" {
  description = "Listener Protocol"
  type        = string
}
variable "DEFAULT_ACTION_TYPE" {
  description = "Default Listener Action"
  type        = string
}
variable "INTERNAL" {
  description = "Whether the ALB is internal"
  type        = bool
}
variable "LOAD_BALANCER_TYPE" {
  description = "Type of Load Balancer"
  type        = string
}
variable "ENABLE_DELETION_PROTECTION" {
  description = "Enable Deletion Protection"
  type        = bool
}
# EC2 Variables
variable "AMI_ID" {
  type = string
}
variable "INSTANCE_TYPE" {
  type = string
}
variable "INSTANCE_NAME" {
  type = string
}
variable "KEY_NAME" {
  type = string
}
variable "KEY_ALGORITHM" {
  description = "Key Algorithm"
  type        = string
}
variable "RSA_BITS" {
  description = "RSA Key Size"
  type        = number
}
variable "PRIVATE_KEY_FILENAME" {
  description = "Local Private Key Filename"
  type        = string
}
variable "PUBLIC_KEY_PATH" {
  type = string
}
# IAM Variables
variable "IAM_ROLE_NAME" {
  type = string
}
variable "INSTANCE_PROFILE_NAME" {
  type = string
}
variable "SSM_POLICY_ARN" {
  type = string
}
variable "EXECUTION_ROLE_NAME" {
  type = string
}
variable "TASK_ROLE_NAME" {
  type = string
}
# ECS Cluster Variables
variable "CLUSTER_NAME" {
  type = string
}
variable "CONTAINER_INSIGHTS" {
  type = string
}
# ECS Task Definition Variables
variable "TASK_FAMILY" {
  description = "Task Definition Family"
  type        = string
}
variable "TASK_CPU" {
  description = "Task CPU"
  type        = number
}
variable "TASK_MEMORY" {
  description = "Task Memory"
  type        = number
}
variable "FRONTEND_CONTAINER_NAME" {
  description = "Frontend Container Name"
  type        = string
}
variable "FRONTEND_IMAGE" {
  description = "Frontend ECR Image"
  type        = string
}
variable "FRONTEND_CONTAINER_PORT" {
  description = "Frontend Container Port"
  type        = number
}
variable "BACKEND_CONTAINER_NAME" {
  description = "Backend Container Name"
  type        = string
}
variable "BACKEND_IMAGE" {
  description = "Backend ECR Image"
  type        = string
}
variable "BACKEND_CONTAINER_PORT" {
  description = "Backend Container Port"
  type        = number
}
variable "LOG_GROUP_NAME" {
  description = "CloudWatch Log Group"
  type        = string
}
# ECS Service Variables
variable "SERVICE_NAME" {
  type = string
}
variable "DESIRED_COUNT" {
  type = number
}