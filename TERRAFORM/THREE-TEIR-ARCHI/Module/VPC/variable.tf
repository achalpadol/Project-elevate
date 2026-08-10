# VPC
variable "VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "REGION_NAME" {
  description = "region name"
  type        = string
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
# Public Subnet
variable "PUBLIC_SUBNET_CIDRS" {
  description = "List of CIDR blocks for Public Subnets"
  type        = list(string)
}
variable "PUBLIC_SUBNET_AZS" {
  description = "List of Availability Zones for Public Subnets"
  type        = list(string)
}
variable "PUBLIC_SUBNET_NAMES" {
  description = "List of names for Public Subnets"
  type        = list(string)
}
variable "MAP_PUBLIC_IP_ON_LAUNCH" {
  description = "Assign public IP automatically"
  type        = bool
}
# Private Application Subnet
variable "PRIVATE_APP_SUBNET_CIDRS" {
  description = "List of CIDR blocks for Private Application Subnets"
  type        = list(string)
}
variable "PRIVATE_APP_SUBNET_AZS" {
  description = "List of Availability Zones for Private Application Subnets"
  type        = list(string)
}
variable "PRIVATE_APP_SUBNET_NAMES" {
  description = "List of names for Private Application Subnets"
  type        = list(string)
}
# Private Database Subnet
variable "PRIVATE_DB_SUBNET_CIDRS" {
  description = "List of CIDR blocks for Private Database Subnets"
  type        = list(string)
}
variable "PRIVATE_DB_SUBNET_AZS" {
  description = "List of Availability Zones for Private Database Subnets"
  type        = list(string)
}
variable "PRIVATE_DB_SUBNET_NAMES" {
  description = "List of names for Private Database Subnets"
  type        = list(string)
}
# NAT Gateway
variable "MY_ELASTIC_IP" {
  type = string
}
variable "MY_NAT_GATEWAY" {
  type = string
}
# Private Route
variable "PRIVATE_ROUTE_CIDR" {
  description = "Destination CIDR for the private route"
  type        = string
}
variable "PRIVATE_ROUTE_TABLE_NAME" {
  description = "Private Route Table Name"
  type        = string
}
# Public Route
variable "PUBLIC_ROUTE_CIDR" {
  description = "Destination CIDR for Public Route Table"
  type        = string
}
variable "PUBLIC_ROUTE_TABLE_NAME" {
  description = "Public Route Table Name"
  type        = string
}