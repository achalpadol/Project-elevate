
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

#############################
# Public Subnets
#############################

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

#############################
# Private App Subnets
#############################

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

#############################
# Private DB Subnets
#############################

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

# ALB variable
variable "alb_name" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "listener_port" {
  type = number
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