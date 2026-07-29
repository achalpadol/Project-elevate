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