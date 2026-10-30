
output "VPC_ID" {
  description = "VPC ID"
  value       = module.vpc.VPC_ID
}
output "VPC_CIDR" {
  description = "VPC CIDR block"
  value       = module.vpc.VPC_CIDR
}
output "PUBLIC_SUBNET_IDS" {
  description = "Public subnet IDs"
  value       = module.vpc.PUBLIC_SUBNET_IDS
}
output "PRIVATE_SUBNET_IDS" {
  description = "Private subnet IDs"
  value       = module.vpc.PRIVATE_SUBNET_IDS
}
output "NAT_GATEWAY_ID" {
  description = "NAT Gateway ID"
  value       = module.vpc.NAT_GATEWAY_ID
}
# ALB Controller
output "ALB_CONTROLLER_ROLE_ARN" {
  description = "IAM role ARN for the AWS Load Balancer Controller"
  value       = module.alb_controller.ALB_CONTROLLER_ROLE_ARN
}
output "ALB_CONTROLLER_HELM_STATUS" {
  description = "Helm release status for the AWS Load Balancer Controller"
  value       = module.alb_controller.ALB_CONTROLLER_HELM_STATUS
}
