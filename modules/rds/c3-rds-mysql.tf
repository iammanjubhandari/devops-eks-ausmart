# RDS MySQL for catalog service
# random_password -> Secrets Manager -> CSI driver -> pod
resource "aws_db_subnet_group" "main" {
  name       = "${var.name_prefix}-rds-subnet-group"
  subnet_ids = var.private_data_subnet_ids

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-rds-subnet-group"
  })
}

# auto-generated, never seen by humans
resource "random_password" "mysql" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_upper        = 4
  min_lower        = 4
  min_numeric      = 4
  min_special      = 2
}

resource "aws_db_parameter_group" "mysql" {
  name   = "${var.name_prefix}-mysql-params"
  family = "mysql8.0"

  parameter {
    name  = "log_output"
    value = "FILE"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "1"
  }

  parameter {
    name         = "wait_timeout"
    value        = "30"
    apply_method = "pending-reboot"
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-mysql-params"
  })
}

resource "aws_db_instance" "mysql" {
  identifier     = "${var.name_prefix}-mysql"
  engine         = "mysql"
  engine_version = "8.0"

  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"

  db_name  = "catalog"
  username = "admin"
  password = random_password.mysql.result

  multi_az               = var.enable_multi_az
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.mysql_security_group_id]
  parameter_group_name   = aws_db_parameter_group.mysql.name
  publicly_accessible    = false

  storage_encrypted = true
  kms_key_id        = var.enable_kms ? var.kms_key_arn : null

  backup_retention_period = var.backup_retention_days
  backup_window           = "16:00-17:00"
  maintenance_window      = "Mon:17:00-Mon:18:00"

  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = !var.deletion_protection
  final_snapshot_identifier = var.deletion_protection ? "${var.name_prefix}-mysql-final" : null

  tags = merge(var.common_tags, {
    Name    = "${var.name_prefix}-mysql"
    Service = "catalog"
  })

  depends_on = [aws_db_parameter_group.mysql]
}

# JSON with all connection details
resource "aws_secretsmanager_secret" "mysql" {
  name                    = "${var.name_prefix}/rds/catalog-credentials"
  recovery_window_in_days = var.secrets_recovery_window

  tags = merge(var.common_tags, {
    Name    = "${var.name_prefix}-rds-catalog-credentials"
    Service = "catalog"
  })
}

resource "aws_secretsmanager_secret_version" "mysql" {
  secret_id = aws_secretsmanager_secret.mysql.id

  secret_string = jsonencode({
    username = "admin"
    password = random_password.mysql.result
    host     = aws_db_instance.mysql.address
    port     = 3306
    dbname   = "catalog"
  })
}
