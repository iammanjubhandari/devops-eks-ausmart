# ExternalDNS - watches Ingress resources and creates Route53 records
resource "aws_iam_role" "external_dns" {
  name = "${var.name_prefix}-external-dns-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "pods.eks.amazonaws.com" }
      Action    = ["sts:AssumeRole", "sts:TagSession"]
    }]
  })

  tags = var.common_tags
}
