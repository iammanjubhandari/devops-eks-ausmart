# RDS MySQL - only EKS nodes can reach port 3306
resource "aws_security_group" "rds_mysql" {
  name        = "${var.name_prefix}-sg-rds-mysql"
  description = "RDS MySQL — port 3306 from EKS nodes only"
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-sg-rds-mysql"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_mysql_from_eks" {
  security_group_id            = aws_security_group.rds_mysql.id
  description                  = "MySQL from EKS nodes"
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.eks_nodes.id
}

# RDS PostgreSQL - only EKS nodes can reach port 5432
resource "aws_security_group" "rds_postgres" {
  name        = "${var.name_prefix}-sg-rds-postgres"
  description = "RDS PostgreSQL — port 5432 from EKS nodes only"
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-sg-rds-postgres"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_postgres_from_eks" {
  security_group_id            = aws_security_group.rds_postgres.id
  description                  = "PostgreSQL from EKS nodes"
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.eks_nodes.id
}
