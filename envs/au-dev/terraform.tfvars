# au-dev environment config

aws_region   = "ap-southeast-2"
project_name = "ausmart"
environment  = "dev"
owner        = "manju"

# VPC
vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_app_subnet_cidrs  = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
private_data_subnet_cidrs = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
availability_zones        = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]

single_nat_gateway = true  # saves ~$70/mo vs 3 NATs

# VPC endpoints - interface ones cost ~$7/mo each (6 endpoints = $44/mo)
# gateway endpoints (S3, DynamoDB) are always on and free
enable_vpc_endpoints     = false   # enable in prod
enable_endpoint_ssm      = false   # SSM for node debugging, enable if needed
enable_flow_logs         = false
flow_logs_retention_days = 14

cluster_name = "ausmart-eks"

# EKS
cluster_version    = "1.31"
node_instance_type = "t3.medium"
node_min_size      = 1
node_max_size      = 6
node_desired_size  = 3
node_disk_size     = 30
public_access_cidrs = ["0.0.0.0/0"]  # prod: ["YOUR.IP/32"]

# Security
enable_kms = false  # ~$3/mo for 3 CMKs
enable_waf = false  # ~$10/mo for WebACL + managed rules

# Secrets: CSI driver + AWS provider installed via eks-addons module
# SecretProviderClass manifests come in Phase 3
