# EKS worker nodes SG
# Using standalone rules so we can add/remove without recreating the SG
resource "aws_security_group" "eks_nodes" {
  name        = "${var.name_prefix}-sg-eks-nodes"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, {
    Name                     = "${var.name_prefix}-sg-eks-nodes"
    "karpenter.sh/discovery" = var.cluster_name
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "eks_nodes_all_outbound" {
  security_group_id = aws_security_group.eks_nodes.id
  description       = "All outbound traffic"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# self-referencing rule for node-to-node comms
resource "aws_vpc_security_group_ingress_rule" "eks_nodes_self" {
  security_group_id            = aws_security_group.eks_nodes.id
  description                  = "Node-to-node communication"
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.eks_nodes.id
}
