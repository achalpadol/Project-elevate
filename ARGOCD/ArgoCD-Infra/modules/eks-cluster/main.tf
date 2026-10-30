
# EKS Cluster
resource "aws_eks_cluster" "this_eks_cluster" {
  name     = var.EKS_CLUSTER_NAME
  version  = var.EKS_CLUSTER_VERSION
  role_arn = var.EKS_CLUSTER_ROLE_ARN
  vpc_config {
    subnet_ids              = var.PRIVATE_SUBNET_IDS
    endpoint_private_access = var.PRIVATE_ENDPOINT_ACCESS
    endpoint_public_access  = var.PUBLIC_ENDPOINT_ACCESS
    public_access_cidrs     = var.PUBLIC_ACCESS_CIDRS
  }
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  tags = merge(var.COMMON_TAGS, {
    Name = var.EKS_CLUSTER_NAME
  })

}
# Retrieve the OIDC issuer certificate
data "tls_certificate" "this_oidc_certificate" {
  url = aws_eks_cluster.this_eks_cluster.identity[0].oidc[0].issuer
}
# Create OIDC Identity Provider for IRSA
resource "aws_iam_openid_connect_provider" "this_oidc_provider" {
  url = aws_eks_cluster.this_eks_cluster.identity[0].oidc[0].issuer
  client_id_list = [
    "sts.amazonaws.com"
  ]
  thumbprint_list = [
    data.tls_certificate.this_oidc_certificate.certificates[0].sha1_fingerprint
  ]
  tags = merge(var.COMMON_TAGS, {
    Name = "${var.EKS_CLUSTER_NAME}-oidc"
  })
}
