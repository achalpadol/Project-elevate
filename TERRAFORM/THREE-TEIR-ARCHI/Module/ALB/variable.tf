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