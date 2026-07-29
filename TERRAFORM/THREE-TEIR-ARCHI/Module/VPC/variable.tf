

# VPC 
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# public subnet
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for Public Subnets"
  type        = list(string)
}

variable "public_subnet_azs" {
  description = "List of Availability Zones for Public Subnets"
  type        = list(string)
}

variable "public_subnet_names" {
  description = "List of names for Public Subnets"
  type        = list(string)
}

# Private subnet
variable "private_app_subnet_cidrs" {
  description = "List of CIDR blocks for Private Application Subnets"
  type        = list(string)
}

variable "private_app_subnet_azs" {
  description = "List of Availability Zones for Private Application Subnets"
  type        = list(string)
}

variable "private_app_subnet_names" {
  description = "List of names for Private Application Subnets"
  type        = list(string)
}

# Private Database Subnet 

variable "private_db_subnet_cidrs" {
  description = "List of CIDR blocks for Private Database Subnets"
  type        = list(string)
}

variable "private_db_subnet_azs" {
  description = "List of Availability Zones for Private Database Subnets"
  type        = list(string)
}

variable "private_db_subnet_names" {
  description = "List of names for Private Database Subnets"
  type        = list(string)
}

