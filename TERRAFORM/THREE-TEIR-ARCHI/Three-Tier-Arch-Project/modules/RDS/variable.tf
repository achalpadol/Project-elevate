variable "DB_SUBNET_GROUP_NAME" {
  type = string
}
variable "PRIVATE_DB_SUBNET_IDS" {
  type = list(string)
}
variable "DB_SECURITY_GROUP_ID" {
  type = string
}
variable "DB_IDENTIFIER" {
  type = string
}
variable "ENGINE" {
  type = string
}
variable "ENGINE_VERSION" {
  type = string
}
variable "INSTANCE_CLASS" {
  type = string
}
variable "ALLOCATED_STORAGE" {
  type = number
}
variable "STORAGE_TYPE" {
  type = string
}
variable "DB_NAME" {
  type = string
}
variable "USERNAME" {
  type = string
}
variable "PASSWORD" {
  type      = string
  sensitive = true
}
variable "PUBLICLY_ACCESSIBLE" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
}
variable "SKIP_FINAL_SNAPSHOT" {
  description = "Skip final snapshot when deleting the RDS instance"
  type        = bool
}
variable "RDS_COMMON_TAGS"{
  type = map(string)
}