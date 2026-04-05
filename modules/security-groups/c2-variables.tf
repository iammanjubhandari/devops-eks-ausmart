variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block for internal rules"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name - needed for karpenter discovery tag"
  type        = string
  default     = ""
}
