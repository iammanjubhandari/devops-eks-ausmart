# AppRegistry first - its tag feeds into common_tags for all other modules
# Uses base_tags not common_tags to avoid circular dependency
module "appregistry" {
  source = "../../modules/appregistry"

  name_prefix  = local.name_prefix
  common_tags  = local.base_tags
  project_name = var.project_name
  environment  = var.environment
  owner        = var.owner
}

# KMS keys - off in dev, on in prod (~$3/mo for 3 keys)
module "kms" {
  source = "../../modules/kms"

  name_prefix = local.name_prefix
  common_tags = local.common_tags
  enable_kms  = var.enable_kms
}

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

# Security groups - needs vpc_id from VPC module
module "security_groups" {
  source = "../../modules/security-groups"

  name_prefix  = local.name_prefix
  common_tags  = local.common_tags
  vpc_id       = module.vpc.vpc_id
  vpc_cidr     = module.vpc.vpc_cidr
  cluster_name = var.cluster_name
}

# EKS cluster - needs VPC subnets, SGs, and optionally KMS for etcd encryption
module "eks_cluster" {
  source = "../../modules/eks-cluster"

  name_prefix            = local.name_prefix
  common_tags            = local.common_tags
  cluster_name           = var.cluster_name
  cluster_version        = var.cluster_version
  vpc_id                 = module.vpc.vpc_id
  private_app_subnet_ids = module.vpc.private_app_subnet_ids
  eks_nodes_sg_id        = module.security_groups.eks_nodes_sg_id
  node_instance_type     = var.node_instance_type
  node_min_size          = var.node_min_size
  node_max_size          = var.node_max_size
  node_desired_size      = var.node_desired_size
  enable_kms             = var.enable_kms
  kms_key_arn            = var.enable_kms ? module.kms.eks_key_arn : ""
  public_access_cidrs    = var.public_access_cidrs

  depends_on = [module.vpc, module.security_groups, module.kms]
}

# EKS add-ons - cluster must exist first
module "eks_addons" {
  source = "../../modules/eks-addons"

  name_prefix                        = local.name_prefix
  common_tags                        = local.common_tags
  cluster_name                       = module.eks_cluster.cluster_name
  cluster_endpoint                   = module.eks_cluster.cluster_endpoint
  cluster_certificate_authority_data = module.eks_cluster.cluster_certificate_authority_data
  cluster_oidc_issuer_url            = module.eks_cluster.cluster_oidc_issuer_url
  node_group_role_arn                = module.eks_cluster.node_group_role_arn
  vpc_id                             = module.vpc.vpc_id

  depends_on = [module.eks_cluster]
}
