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
