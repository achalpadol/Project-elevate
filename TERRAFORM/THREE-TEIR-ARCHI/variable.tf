
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}
variable "region_name"{
  type = "string"
}
variable "enable_dns_support" {
  description = "Enable DNS Support"
  type = bool
}
variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames"
  type = bool
}
variable "vpc_name" {
  description = "VPC Name"
  type = string
} 
variable "igw_name"{
  type = string
}

# Public Subnets

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "public_subnet_azs" {
  description = "Public subnet AZs"
  type        = list(string)
}

variable "public_subnet_names" {
  description = "Public subnet names"
  type        = list(string)
}
variable "map_public_ip_on_launch" {
  description = "Assign public IP automatically"
  type = bool
}

# Private App Subnets

variable "private_app_subnet_cidrs" {
  description = "Application subnet CIDRs"
  type        = list(string)
}

variable "private_app_subnet_azs" {
  description = "Application subnet AZs"
  type        = list(string)
}

variable "private_app_subnet_names" {
  description = "Application subnet names"
  type        = list(string)
}

# Private DB Subnets

variable "private_db_subnet_cidrs" {
  description = "Database subnet CIDRs"
  type        = list(string)
}

variable "private_db_subnet_azs" {
  description = "Database subnet AZs"
  type        = list(string)
}

variable "private_db_subnet_names" {
  description = "Database subnet names"
  type        = list(string)
}

# Sg variables
variable "sg_name" {
  type        = list(string)
}

variable "alb_ports" {
  type        = list(number)
}

variable "app_ports" {
  type        = list(number)
}

variable "db_ports" {
  type        = list(number)
}

variable "alb_ingress_cidr" {
  description = "CIDR block allowed to access ALB"
  type = list(string)
}

variable "egress_cidr" {
  description = "CIDR block for outbound traffic"
  type = list(string)
}

variable "egress_from_port" {
  description = "Starting outbound port"
  type = number
}

variable "egress_to_port" {
  description = "Ending outbound port"
  type = number
}

variable "egress_protocol" {
  description = "Protocol for outbound traffic"
  type = string
}
variable "ingress_protocol" {
  description = "Protocol used for ingress rules"
  type = string
}

variable "my_lastic_ip"{
  type = "string"
}

variable "my_nat_gateway"{
  type "string"
}

variable "private_route_cidr" {
  description = "Destination CIDR for the private route"
  type = string
}

variable "private_route_table_name" {
  description = "Private Route Table Name"
  type = string
}
variable "public_route_cidr" {
  description = "Destination CIDR for Public Route Table"
  type = string
}

variable "public_route_table_name" {
  description = "Public Route Table Name"
  type = string
}

# RDS variable
variable "db_subnet_group_name" {
  type = string
}

variable "db_identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "storage_type" {
  type = string
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}
variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type = bool
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when deleting the RDS instance"
  type = bool
}

# ALB variable
variable "alb_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "alb_security_group_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "target_group_name" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  description = "Target Group Protocol"
  type = string
}

variable "health_check_path" {
  description = "Health Check Path"
  type = string
}

variable "listener_port" {
  type = number
}

variable "listener_protocol" {
  description = "Listener Protocol"
  type = string
}

variable "default_action_type" {
  description = "Default Listener Action"
  type = string
}

variable "internal" {
  description = "Whether the ALB is internal"
  type = bool
}

variable "load_balancer_type" {
  description = "Type of Load Balancer"
  type = string
}

variable "enable_deletion_protection" {
  description = "Enable Deletion Protection"
  type = bool
}

# ec2 instance instance_id

variable "instance_id" {
  type = string
}

# EC2 variable
variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "key_name" {
  type = string
}

variable "key_algorithm" {
  description = "Key Algorithm"
  type = string
}

variable "rsa_bits" {
  description = "RSA Key Size"
  type = number
}
variable "private_key_filename" {
  description = "Local Private Key Filename"
  type = string
}

variable "public_key_path" {
  type = string
}

#IAM variable for session manager

variable "iam_role_name" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "ssm_policy_arn" {
  type = string
}


