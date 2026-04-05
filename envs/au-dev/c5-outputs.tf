# AppRegistry
output "appregistry_application_arn" {
  description = "AppRegistry application ARN (for Cost Explorer)"
  value       = module.appregistry.application_arn
}

# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "Private app subnet IDs (EKS nodes)"
  value       = module.vpc.private_app_subnet_ids
}

output "private_data_subnet_ids" {
  description = "Private data subnet IDs (RDS, ElastiCache)"
  value       = module.vpc.private_data_subnet_ids
}

output "s3_vpc_endpoint_id" {
  value = module.vpc.s3_vpc_endpoint_id
}

# KMS
output "kms_s3_key_arn" {
  description = "KMS key ARN for S3 encryption"
  value       = module.kms.s3_key_arn
}

output "kms_eks_key_arn" {
  description = "KMS key ARN for EKS etcd encryption"
  value       = module.kms.eks_key_arn
}

output "kms_rds_key_arn" {
  description = "KMS key ARN for RDS encryption"
  value       = module.kms.rds_key_arn
}

# Security Groups
output "eks_nodes_sg_id" {
  description = "Security group ID for EKS nodes"
  value       = module.security_groups.eks_nodes_sg_id
}

output "rds_mysql_sg_id" {
  value = module.security_groups.rds_mysql_sg_id
}

output "rds_postgres_sg_id" {
  value = module.security_groups.rds_postgres_sg_id
}

output "elasticache_sg_id" {
  value = module.security_groups.elasticache_sg_id
}

# EKS
output "cluster_name" {
  value = module.eks_cluster.cluster_name
}

output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}

output "cluster_arn" {
  value = module.eks_cluster.cluster_arn
}

output "cluster_oidc_issuer_url" {
  value = module.eks_cluster.cluster_oidc_issuer_url
}

output "configure_kubectl" {
  description = "Run this to configure kubectl"
  value       = "aws eks update-kubeconfig --name ${module.eks_cluster.cluster_name} --region ${var.aws_region}"
}

# EKS Add-ons
output "lbc_role_arn" {
  value = module.eks_addons.lbc_role_arn
}

output "ebs_csi_role_arn" {
  value = module.eks_addons.ebs_csi_role_arn
}
