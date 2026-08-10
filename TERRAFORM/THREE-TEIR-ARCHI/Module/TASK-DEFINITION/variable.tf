variable "TASK_FAMILY" {
  description = "Task Definition Family"
  type        = string
}
variable "TASK_CPU" {
  description = "Task CPU"
  type        = number
}
variable "TASK_MEMORY" {
  description = "Task Memory"
  type        = number
}
variable "EXECUTION_ROLE_ARN" {
  description = "Execution Role ARN"
  type        = string
}
variable "TASK_ROLE_ARN" {
  description = "Task Role ARN"
  type        = string
}
variable "FRONTEND_CONTAINER_NAME" {
  description = "Frontend Container Name"
  type        = string
}
variable "FRONTEND_IMAGE" {
  description = "Frontend ECR Image"
  type        = string
}
variable "FRONTEND_CONTAINER_PORT" {
  description = "Frontend Container Port"
  type        = number
}
variable "BACKEND_CONTAINER_NAME" {
  description = "Backend Container Name"
  type        = string
}
variable "BACKEND_IMAGE" {
  description = "Backend ECR Image"
  type        = string
}
variable "BACKEND_CONTAINER_PORT" {
  description = "Backend Container Port"
  type        = number
}
variable "REGION_NAME" {
  description = "AWS Region"
  type        = string
}
variable "LOG_GROUP_NAME" {
  description = "CloudWatch Log Group"
  type        = string
}