variable "CLUSTER_NAME" {
  description = "ECS Cluster Name"
  type        = string
}
variable "CONTAINER_INSIGHTS" {
  description = "Enable ECS Container Insights"
  type        = string
  default     = "enabled"
}
