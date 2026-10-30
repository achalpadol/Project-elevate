
# AWS Provider
provider "aws" {
  region = var.AWS_REGION

  default_tags {
    tags = var.COMMON_TAGS
  }
}
# Kubernetes Provider
provider "kubernetes" {
  host = module.eks_cluster.EKS_CLUSTER_ENDPOINT

  cluster_ca_certificate = base64decode(
    module.eks_cluster.EKS_CLUSTER_CERTIFICATE_AUTHORITY_DATA
  )

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"

    args = [
      "eks",
      "get-token",
      "--cluster-name",
      var.EKS_CLUSTER_NAME,
      "--region",
      var.AWS_REGION
    ]
  }
}

# Helm Provider (version 3 syntax)
provider "helm" {
  kubernetes = {
    host = module.eks_cluster.EKS_CLUSTER_ENDPOINT

    cluster_ca_certificate = base64decode(
      module.eks_cluster.EKS_CLUSTER_CERTIFICATE_AUTHORITY_DATA
    )

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"

      args = [
        "eks",
        "get-token",
        "--cluster-name",
        var.EKS_CLUSTER_NAME,
        "--region",
        var.AWS_REGION
      ]
    }
  }
}
