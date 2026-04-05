variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "ausmart-eks"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.31"
}

# Networking
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_app_subnet_ids" {
  description = "Private app subnet IDs for EKS nodes"
  type        = list(string)
}

variable "eks_nodes_sg_id" {
  description = "Security group ID for EKS worker nodes"
  type        = string
}

# Node group - used in c5 but defined here so all vars are in one place
variable "node_instance_type" {
  description = "EC2 instance type for managed node group"
  type        = string
  default     = "t3.medium"
}

variable "node_min_size" {
  description = "Min nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Max nodes"
  type        = number
  default     = 6
}

variable "node_desired_size" {
  description = "Desired nodes"
  type        = number
  default     = 3
}

variable "node_disk_size" {
  description = "EBS volume size in GB"
  type        = number
  default     = 30
}

# Security
variable "enable_kms" {
  description = "Enable KMS encryption for EKS secrets"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "KMS key ARN for EKS secrets encryption"
  type        = string
  default     = ""
}

variable "public_access_cidrs" {
  description = "CIDRs allowed to hit EKS API (lock down in prod)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
