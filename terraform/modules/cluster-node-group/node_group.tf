resource "aws_eks_node_group" "eks_cluster_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "devops_eks_node_group_on_demand"
  node_role_arn   = aws_iam_role.eks_mng_role.arn
  subnet_ids = [
    var.private_subnet_1a,
    var.private_subnet_1b
  ]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_mng_role_worker,
    aws_iam_role_policy_attachment.eks_mng_role_cni,
    aws_iam_role_policy_attachment.eks_mng_role_registry,
  ]

  tags = var.tags
}