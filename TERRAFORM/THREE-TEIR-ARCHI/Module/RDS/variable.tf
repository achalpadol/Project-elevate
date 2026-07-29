variable "db_subnet_group_name" {
  type = string
}

variable "private_db_subnet_ids" {
  type = list(string)
}

variable "db_security_group_id" {
  type = string
}

variable "db_identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "storage_type" {
  type = string
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}