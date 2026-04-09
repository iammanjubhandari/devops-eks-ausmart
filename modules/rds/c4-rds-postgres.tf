# RDS PostgreSQL for orders service
resource "random_password" "postgres" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_upper        = 4
  min_lower        = 4
  min_numeric      = 4
  min_special      = 2
}

resource "aws_db_parameter_group" "postgres" {
  name   = "${var.name_prefix}-postgres-params"
  family = "postgres15"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  parameter {
    name  = "idle_in_transaction_session_timeout"
    value = "30000"
  }

  parameter {
    name  = "statement_timeout"
    value = "30000"
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-postgres-params"
  })
}

resource "aws_db_instance" "postgres" {
  identifier     = "${var.name_prefix}-postgres"
  engine         = "postgres"
  engine_version = "15"

  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"

  db_name  = "orders"
  username = "admin"
  password = random_password.postgres.result

  multi_az               = var.enable_multi_az
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.postgres_security_group_id]
  parameter_group_name   = aws_db_parameter_group.postgres.name
  publicly_accessible    = false

  storage_encrypted = true
  kms_key_id        = var.enable_kms ? var.kms_key_arn : null

  backup_retention_period = var.backup_retention_days
  backup_window           = "16:00-17:00"
  maintenance_window      = "Mon:17:00-Mon:18:00"

  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = !var.deletion_protection
  final_snapshot_identifier = var.deletion_protection ? "${var.name_prefix}-postgres-final" : null

  tags = merge(var.common_tags, {
    Name    = "${var.name_prefix}-postgres"
    Service = "orders"
  })

  depends_on = [aws_db_parameter_group.postgres]
}

resource "aws_secretsmanager_secret" "postgres" {
  name                    = "${var.name_prefix}/rds/orders-credentials"
  recovery_window_in_days = var.secrets_recovery_window

  tags = merge(var.common_tags, {
    Name    = "${var.name_prefix}-rds-orders-credentials"
    Service = "orders"
  })
}

resource "aws_secretsmanager_secret_version" "postgres" {
  secret_id = aws_secretsmanager_secret.postgres.id

  secret_string = jsonencode({
    username = "admin"
    password = random_password.postgres.result
    host     = aws_db_instance.postgres.address
    port     = 5432
    dbname   = "orders"
  })
}
