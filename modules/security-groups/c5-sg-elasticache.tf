# ElastiCache Redis - only EKS nodes can reach port 6379
resource "aws_security_group" "elasticache" {
  name        = "${var.name_prefix}-sg-elasticache"
  description = "ElastiCache Redis — port 6379 from EKS nodes only"
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-sg-elasticache"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "elasticache_from_eks" {
  security_group_id            = aws_security_group.elasticache.id
  description                  = "Redis from EKS nodes"
  from_port                    = 6379
  to_port                      = 6379
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.eks_nodes.id
}
