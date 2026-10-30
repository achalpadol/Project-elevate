
# EKS Cluster IAM Role
resource "aws_iam_role" "this_eks_cluster_role" {
  name = var.EKS_CLUSTER_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.COMMON_TAGS, {
    Name = var.EKS_CLUSTER_ROLE_NAME
  })
}

resource "aws_iam_role_policy_attachment" "this_eks_cluster_policy" {
  role       = aws_iam_role.this_eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# EKS Worker Node IAM Role
resource "aws_iam_role" "this_eks_node_role" {
  name = var.EKS_NODE_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.COMMON_TAGS, {
    Name = var.EKS_NODE_ROLE_NAME
  })
}

resource "aws_iam_role_policy_attachment" "this_eks_node_policy" {
  role       = aws_iam_role.this_eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "this_eks_cni_policy" {
  role       = aws_iam_role.this_eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role_policy_attachment" "this_ecr_pull_policy" {
  role       = aws_iam_role.this_eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

