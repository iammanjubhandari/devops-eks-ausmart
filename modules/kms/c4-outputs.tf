output "s3_key_arn" {
  description = "KMS key ARN for S3 encryption"
  value       = var.enable_kms ? aws_kms_key.s3[0].arn : null
}

output "eks_key_arn" {
  description = "KMS key ARN for EKS etcd encryption"
  value       = var.enable_kms ? aws_kms_key.eks[0].arn : null
}

output "rds_key_arn" {
  description = "KMS key ARN for RDS encryption"
  value       = var.enable_kms ? aws_kms_key.rds[0].arn : null
}
