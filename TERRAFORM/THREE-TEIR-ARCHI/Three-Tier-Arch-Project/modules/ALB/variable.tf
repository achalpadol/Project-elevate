variable "ALB_NAME" {
  type = string
}
variable "VPC_ID" {
  type = string
}
variable "ALB_COMMON_TAGS" {
  type = map(string)
}
variable "ALB_SECURITY_GROUP_ID" {
  type = string
}
variable "PUBLIC_SUBNET_IDS" {
  type = list(string)
}
variable "TARGET_GROUP_NAME" {
  type = string
}
variable "TARGET_GROUP_PORT" {
  type = number
}
variable "TARGET_GROUP_PROTOCOL" {
  description = "Target Group Protocol"
  type        = string
}
variable "HEALTH_CHECK_PATH" {
  description = "Health Check Path"
  type        = string
}
variable "LISTENER_PORT" {
  type = number
}
variable "LISTENER_PROTOCOL" {
  description = "Listener Protocol"
  type        = string
}
variable "DEFAULT_ACTION_TYPE" {
  description = "Default Listener Action"
  type        = string
}
variable "INTERNAL" {
  description = "Whether the ALB is internal"
  type        = bool
}
variable "LOAD_BALANCER_TYPE" {
  description = "Type of Load Balancer"
  type        = string
}
variable "ENABLE_DELETION_PROTECTION" {
  description = "Enable Deletion Protection"
  type        = bool
}
variable "INSTANCE_ID" {
  type = string
}
