variable "SECURITY_GROUPS" {
  type = map(object({
    ports = list(number)
  }))
}
variable "VPC_ID" {
  type = string
}