# Global
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Project name used in resource naming and tags"
  type        = string
  default     = "ausmart"
}

variable "environment" {
  description = "Environment name: dev, staging, prod"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Team or person who owns these resources"
  type        = string
  # set in terraform.tfvars
}

# VPC
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs - one per AZ"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "Private app subnet CIDRs (EKS nodes) - one per AZ"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_data_subnet_cidrs" {
  description = "Private data subnet CIDRs (RDS, ElastiCache) - one per AZ"
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
}

variable "availability_zones" {
  description = "AZs to use - must match subnet count"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

variable "single_nat_gateway" {
  description = "Single NAT for dev, one per AZ for prod"
  type        = bool
  default     = true
}

# VPC feature flags
variable "enable_vpc_endpoints" {
  description = "Turn on interface endpoints (~$7/mo each)"
  type        = bool
  default     = false
}

variable "enable_flow_logs" {
  description = "Enable VPC flow logs to CloudWatch"
  type        = bool
  default     = false
}

variable "flow_logs_retention_days" {
  description = "Retension days for flow logs"
  type        = number
  default     = 14
}

variable "cluster_name" {
  description = "EKS cluster name - used for subnet tagging"
  type        = string
  default     = "ausmart-eks"
}

# AppRegistry
variable "github_repo" {
  description = "GitHub repo URL for AppRegistry metadata"
  type        = string
  default     = "github.com/iammanjubhandari/devops-eks-ausmart"
}

# KMS
variable "enable_kms" {
  description = "Create customer-managed KMS keys - off for dev, on for prod"
  type        = bool
  default     = false
}
