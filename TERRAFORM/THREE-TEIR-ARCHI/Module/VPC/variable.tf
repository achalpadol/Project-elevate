

# VPC 
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "region_name" {
  description = "region name"
  type        = string
}
variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames"
  type        = bool
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}
variable "igw_name" {
  type = string
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
variable "map_public_ip_on_launch" {
  description = "Assign public IP automatically"
  type        = bool
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
variable "my_elastic_ip" {
  type = string
}
variable "my_nat_gateway" {
  type = string
}
variable "private_route_cidr" {
  description = "Destination CIDR for the private route"
  type        = string
}

variable "private_route_table_name" {
  description = "Private Route Table Name"
  type        = string
}
variable "public_route_cidr" {
  description = "Destination CIDR for Public Route Table"
  type        = string
}

variable "public_route_table_name" {
  description = "Public Route Table Name"
  type        = string
}
