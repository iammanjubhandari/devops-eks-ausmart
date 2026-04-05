output "eks_nodes_sg_id" {
  description = "Security group ID for EKS worker nodes"
  value       = aws_security_group.eks_nodes.id
}

output "rds_mysql_sg_id" {
  description = "Security group ID for RDS MySQL"
  value       = aws_security_group.rds_mysql.id
}

output "rds_postgres_sg_id" {
  description = "Security group ID for RDS PostgreSQL"
  value       = aws_security_group.rds_postgres.id
}

output "elasticache_sg_id" {
  description = "Security group ID for ElastiCache Redis"
  value       = aws_security_group.elasticache.id
}
