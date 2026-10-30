
variable "VPC_NAME" {
  description = "Name of the VPC"
  type        = string
}
variable "VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "PUBLIC_SUBNETS" {
  description = "Public subnet configuration"
  type = map(object({
    NAME = string
    CIDR = string
    AZ   = string
  }))
}
variable "PRIVATE_SUBNETS" {
  description = "Private subnet configuration"
  type = map(object({
    NAME = string
    CIDR = string
    AZ   = string
  }))
}
variable "NAT_SUBNET_KEY" {
  description = "Key of the public subnet used for the NAT Gateway"
  type        = string
}
variable "COMMON_TAGS" {
  description = "Common tags for all VPC resources"
  type        = map(string)
}
