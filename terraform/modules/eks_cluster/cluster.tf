resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks_cluster_devops"
  role_arn = aws_iam_role.eks_master_role.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = [
      var.public_subnet_1a,
      var.public_subnet_1b
    ]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role,
    aws_iam_role_policy_attachment.eks_cluster_service
  ]

  tags = merge(
    var.tags,
    {
      Name = "devops_eks_cluster"
    }
  )
}
