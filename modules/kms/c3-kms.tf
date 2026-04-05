data "aws_caller_identity" "current" {}

# S3 key - for terraform state and app data buckets
resource "aws_kms_key" "s3" {
  count = var.enable_kms ? 1 : 0

  description             = "CMK for S3 bucket encryption — ${var.name_prefix}"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "RootAccountFullAccess"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        Action    = "kms:*"
        Resource  = "*"
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name    = "${var.name_prefix}-kms-s3"
    Purpose = "S3 encryption"
  })
}

resource "aws_kms_alias" "s3" {
  count = var.enable_kms ? 1 : 0

  name          = "alias/${var.name_prefix}-s3"
  target_key_id = aws_kms_key.s3[0].key_id
}
