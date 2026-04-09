output "mysql_endpoint" {
  description = "RDS MySQL endpoint address"
  value       = aws_db_instance.mysql.address
}

output "mysql_port" {
  value = aws_db_instance.mysql.port
}

output "mysql_secret_arn" {
  description = "Secrets Manager ARN for MySQL credentials"
  value       = aws_secretsmanager_secret.mysql.arn
}

output "postgres_endpoint" {
  description = "RDS PostgreSQL endpoint address"
  value       = aws_db_instance.postgres.address
}

output "postgres_port" {
  value = aws_db_instance.postgres.port
}

output "postgres_secret_arn" {
  description = "Secrets Manager ARN for PostgreSQL credentials"
  value       = aws_secretsmanager_secret.postgres.arn
}
