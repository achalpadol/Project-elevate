variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "private_app_subnet_id" {
  type = string
}

variable "app_security_group_id" {
  type = string
}

variable "key_name" {
  description = "AWS Key Pair Name"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key (.pub)"
  type        = string
}
variable "iam_instance_profile" {
  type = string
}