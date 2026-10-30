
output "ALB_CONTROLLER_ROLE_ARN" {
  description = "IAM role ARN used by AWS Load Balancer Controller"
  value       = aws_iam_role.this_alb_controller_role.arn
}
output "ALB_CONTROLLER_POLICY_ARN" {
  description = "IAM policy ARN attached to the controller role"
  value       = aws_iam_policy.this_alb_controller_policy.arn
}
output "ALB_CONTROLLER_SERVICE_ACCOUNT" {
  description = "Kubernetes service account used by the controller"
  value       = kubernetes_service_account_v1.this_alb_controller_service_account.metadata[0].name
}
output "ALB_CONTROLLER_HELM_STATUS" {
  description = "Status of the controller Helm release"
  value       = helm_release.this_alb_controller.status
}
