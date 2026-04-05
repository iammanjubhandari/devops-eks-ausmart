variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "common_tags" {
  description = "Base tags (not common_tags - this module creates the app tag)"
  type        = map(string)
}

variable "project_name" {
  description = "Project name for attribute metadata"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "owner" {
  description = "Resource owner"
  type        = string
}

variable "repository" {
  description = "Source code repo URL"
  type        = string
  default     = "github.com/iammanjubhandari/devops-eks-ausmart"
}

variable "description" {
  type    = string
  default = "Production-grade retail store microservices on AWS EKS"
}
