variable "AMI_ID" {
  type = string
}
variable "INSTANCE_TYPE" {
  type = string
}
variable "INSTANCE_NAME" {
  type = string
}
variable "PRIVATE_APP_SUBNET_ID" {
  type = string
}
variable "APP_SECURITY_GROUP_ID" {
  type = string
}
variable "KEY_NAME" {
  description = "AWS Key Pair Name"
  type        = string
}
variable "KEY_ALGORITHM" {
  description = "Key Algorithm"
  type        = string
}
variable "RSA_BITS" {
  description = "RSA Key Size"
  type        = number
}
variable "PRIVATE_KEY_FILENAME" {
  description = "Local Private Key Filename"
  type        = string
}
variable "PUBLIC_KEY_PATH" {
  description = "Path to the public key (.pub)"
  type        = string
}
variable "IAM_INSTANCE_PROFILE" {
  type = string
}