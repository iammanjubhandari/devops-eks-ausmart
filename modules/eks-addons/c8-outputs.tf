output "lbc_role_arn" {
  description = "IAM role ARN for Load Balancer Controller"
  value       = aws_iam_role.lbc.arn
}
