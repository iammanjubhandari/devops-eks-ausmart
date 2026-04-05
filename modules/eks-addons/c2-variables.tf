variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "common_tags" {
  type = map(string)
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_certificate_authority_data" {
  type = string
}

variable "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL - might need this for IRSA fallback"
  type        = string
}

variable "node_group_role_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}
