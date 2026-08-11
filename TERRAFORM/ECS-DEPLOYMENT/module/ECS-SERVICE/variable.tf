variable "SERVICE_NAME" {
  description = "ECS Service Name"
  type        = string
}
variable "CLUSTER_ARN" {
  description = "ECS Cluster ARN"
  type        = string
}
variable "TASK_DEFINITION_ARN" {
  description = "ECS Task Definition ARN"
  type        = string
}
variable "DESIRED_COUNT" {
  description = "Number of running tasks"
  type        = number
}
variable "PRIVATE_SUBNET_IDS" {
  description = "Private Subnet IDs"
  type        = list(string)
}
variable "SECURITY_GROUP_IDS" {
  description = "Security Group IDs"
  type        = list(string)
}
variable "CLUSTER_NAME" {
  description = "Common Tags"
  type        = string
}
variable "TARGET_GROUP_ARN" {
  description = "ALB target group ARN"
  type        = string
}
variable "FRONTEND_CONTAINER_NAME" {
  description = "Frontend container name"
  type        = string
}
variable "FRONTEND_CONTAINER_PORT" {
  description = "Frontend container port"
  type        = number
}