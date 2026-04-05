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
