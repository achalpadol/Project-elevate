variable "vpc_id" {
  description = "VPC ID where Security Groups will be created"
  type        = string
}

variable "sg_name" {
  description = "List of Security Group Names (ALB, APP, DB)"
  type        = list(string)
}

variable "alb_ports" {
  description = "Ports allowed for ALB"
  type        = list(number)
}

variable "app_ports" {
  description = "Ports allowed for Application"
  type        = list(number)
}

variable "db_ports" {
  description = "Ports allowed for Database"
  type        = list(number)
}

variable "alb_ingress_cidr" {
  description = "CIDR block allowed to access ALB"
  type        = list(string)
}

variable "egress_cidr" {
  description = "CIDR block for outbound traffic"
  type        = list(string)
}

variable "egress_from_port" {
  description = "Starting outbound port"
  type        = number
}

variable "egress_to_port" {
  description = "Ending outbound port"
  type        = number
}

variable "egress_protocol" {
  description = "Protocol for outbound traffic"
  type        = string
}
variable "ingress_protocol" {
  description = "Protocol used for ingress rules"
  type        = string
}