data "aws_region" "current" {}

# SG for interface endpoints - only allows HTTPS from within VPC
resource "aws_security_group" "vpc_endpoints" {
  count = var.enable_vpc_endpoints ? 1 : 0

  name        = "${var.name_prefix}-sg-vpc-endpoints"
  description = "Allow HTTPS from VPC CIDR to Interface VPC Endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-sg-vpc-endpoints"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# Gateway endpoints - these are free, always on
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = concat(
    aws_route_table.private_app[*].id,
    aws_route_table.private_data[*].id
  )

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-vpce-s3"
  })
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
  vpc_endpoint_type = "Gateway"

  route_table_ids = concat(
    aws_route_table.private_app[*].id,
    aws_route_table.private_data[*].id
  )

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-vpce-dynamodb"
  })
}

# Interface endpoints - these cost money so they're behind a toggle
locals {
  private_subnet_ids = aws_subnet.private_app[*].id

  interface_endpoints = var.enable_vpc_endpoints ? {
    ecr-api            = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
    ecr-dkr            = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
    sts                = "com.amazonaws.${data.aws_region.current.name}.sts"
    secretsmanager     = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"
    sqs                = "com.amazonaws.${data.aws_region.current.name}.sqs"
    logs               = "com.amazonaws.${data.aws_region.current.name}.logs"
  } : {}

  ssm_endpoints = var.enable_vpc_endpoints && var.enable_endpoint_ssm ? {
    ssm         = "com.amazonaws.${data.aws_region.current.name}.ssm"
    ssmmessages = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  } : {}

  all_interface_endpoints = merge(local.interface_endpoints, local.ssm_endpoints)
}

resource "aws_vpc_endpoint" "interface" {
  for_each = local.all_interface_endpoints

  vpc_id              = aws_vpc.main.id
  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = local.private_subnet_ids
  security_group_ids = [aws_security_group.vpc_endpoints[0].id]

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-vpce-${each.key}"
  })
}
