variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet CIDRs - 3 AZs, 3 tiers
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (ALB, NAT GW) — one per AZ"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private app subnets (EKS nodes) — one per AZ"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_data_subnet_cidrs" {
  description = "CIDR blocks for private data subnets (RDS, ElastiCache) — one per AZ"
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
}

variable "availability_zones" {
  description = "List of AZs to use — must match subnet count"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

variable "single_nat_gateway" {
  description = "Single NAT for dev, one per AZ for prod"
  type        = bool
  default     = true
}

# VPC endpoints - interface ones cost ~$7/mo each
variable "enable_vpc_endpoints" {
  description = "Turn on interface VPC endpoints"
  type        = bool
  default     = false
}

variable "enable_endpoint_ssm" {
  description = "Enable SSM + SSMMessages endpoints for debugging"
  type        = bool
  default     = false
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_logs_retention_days" {
  description = "Retension days for flow logs in CloudWatch"
  type        = number
  default     = 14
}

variable "cluster_name" {
  description = "EKS cluster name for subnet tagging"
  type        = string
  default     = "ausmart-eks"
}
