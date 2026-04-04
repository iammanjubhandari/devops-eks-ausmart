# VPC - everything downstream needs this
module "vpc" {
  source = "../../modules/vpc"

  name_prefix               = local.name_prefix
  common_tags               = local.common_tags
  vpc_cidr                  = var.vpc_cidr
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_app_subnet_cidrs  = var.private_app_subnet_cidrs
  private_data_subnet_cidrs = var.private_data_subnet_cidrs
  availability_zones        = var.availability_zones
  single_nat_gateway        = var.single_nat_gateway
  enable_vpc_endpoints      = var.enable_vpc_endpoints
  enable_flow_logs          = var.enable_flow_logs
  cluster_name              = var.cluster_name
}
