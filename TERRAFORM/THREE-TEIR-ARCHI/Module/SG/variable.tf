variable "VPC_ID" {
  description = "VPC ID where Security Groups will be created"
  type        = string
}
variable "SG_NAME" {
  description = "List of Security Group Names (ALB, APP, DB)"
  type        = list(string)
}
variable "ALB_PORTS" {
  description = "Ports allowed for ALB"
  type        = list(number)
}
variable "APP_PORTS" {
  description = "Ports allowed for Application"
  type        = list(number)
}
variable "DB_PORTS" {
  description = "Ports allowed for Database"
  type        = list(number)
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