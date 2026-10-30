
# IAM policy for AWS Load Balancer Controller
resource "aws_iam_policy" "this_alb_controller_policy" {
  name        = "${var.EKS_CLUSTER_NAME}-alb-controller-policy"
  description = "Permissions for AWS Load Balancer Controller"

  policy = file("${path.module}/iam_policy.json")

  tags = merge(var.COMMON_TAGS, {
    Name = "${var.EKS_CLUSTER_NAME}-alb-controller-policy"
  })
}
# IAM role trusted by the controller's Kubernetes service account
resource "aws_iam_role" "this_alb_controller_role" {
  name = var.ALB_CONTROLLER_ROLE_NAME
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.EKS_CLUSTER_OIDC_PROVIDER_ARN
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(var.EKS_CLUSTER_OIDC_ISSUER, "https://", "")}:aud" = "sts.amazonaws.com"
            "${replace(var.EKS_CLUSTER_OIDC_ISSUER, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
  tags = merge(var.COMMON_TAGS, {
    Name = var.ALB_CONTROLLER_ROLE_NAME
  })
}
# Attach controller permissions to its IAM role
resource "aws_iam_role_policy_attachment" "this_alb_controller_policy_attachment" {
  role       = aws_iam_role.this_alb_controller_role.name
  policy_arn = aws_iam_policy.this_alb_controller_policy.arn
}
# Kubernetes service account for the controller
resource "kubernetes_service_account_v1" "this_alb_controller_service_account" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.this_alb_controller_role.arn
    }
  }
  depends_on = [
    aws_iam_role_policy_attachment.this_alb_controller_policy_attachment
  ]
}
# Install AWS Load Balancer Controller using Helm
resource "helm_release" "this_alb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.ALB_CONTROLLER_CHART_VERSION
  namespace  = "kube-system"
  values = [
    yamlencode({
      clusterName = var.EKS_CLUSTER_NAME
      region      = var.AWS_REGION
      vpcId       = var.VPC_ID

      serviceAccount = {
        create = false
        name   = "aws-load-balancer-controller"
      }
    })
  ]
  depends_on = [
    kubernetes_service_account_v1.this_alb_controller_service_account,
    aws_iam_role_policy_attachment.this_alb_controller_policy_attachment
  ]
}
