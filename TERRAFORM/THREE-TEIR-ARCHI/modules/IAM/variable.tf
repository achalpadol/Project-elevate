variable "IAM_ROLE_NAME" {
  type = string
}
variable "INSTANCE_PROFILE_NAME" {
  type = string
}
variable "SSM_POLICY_ARN" {
  type = string
}
variable "IAM_COMMON_TAGS"{
   type = map(string)
}
