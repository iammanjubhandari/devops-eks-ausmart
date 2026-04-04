output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  description = "List of private app subnet IDs (EKS nodes)"
  value       = aws_subnet.private_app[*].id
}

output "private_data_subnet_ids" {
  description = "List of private data subnet IDs (RDS, ElastiCache)"
  value       = aws_subnet.private_data[*].id
}

output "s3_vpc_endpoint_id" {
  description = "S3 Gateway VPC endpoint ID"
  value       = aws_vpc_endpoint.s3.id
}

output "vpc_endpoint_sg_id" {
  description = "Security group ID for Interface VPC endpoints"
  value       = var.enable_vpc_endpoints ? aws_security_group.vpc_endpoints[0].id : null
}

output "flow_log_id" {
  description = "VPC Flow Log ID"
  value       = var.enable_flow_logs ? aws_flow_log.main[0].id : null
}
