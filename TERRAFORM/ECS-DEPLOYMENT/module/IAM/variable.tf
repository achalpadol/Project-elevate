variable "EXECUTION_ROLE_NAME" {
  description = "ECS Task Execution Role Name"
  type        = string
}
variable "TASK_ROLE_NAME" {
  description = "ECS Task Role Name"
  type        = string
}
variable "IAM_COMMON_TAGS" {
  type = map(string)
}