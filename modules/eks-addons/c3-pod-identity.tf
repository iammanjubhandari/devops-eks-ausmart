data "aws_eks_cluster" "main" {
  name = var.cluster_name
}

data "aws_eks_addon_version" "pod_identity" {
  addon_name         = "eks-pod-identity-agent"
  kubernetes_version = data.aws_eks_cluster.main.version
  most_recent        = true
}

# pod identity agent - needed before any other add-on that uses pod identity
resource "aws_eks_addon" "pod_identity" {
  cluster_name  = var.cluster_name
  addon_name    = "eks-pod-identity-agent"
  addon_version = data.aws_eks_addon_version.pod_identity.version

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-addon-pod-identity"
  })
}
