locals {
  name_prefix = "${var.project_name}-${var.environment}"

  base_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = var.owner
    Region      = var.aws_region
  }

  # AppRegistry tag merged in so Cost Explorer groups everything under one app
  common_tags = merge(
    local.base_tags,
    module.appregistry.application_tag
  )
}
