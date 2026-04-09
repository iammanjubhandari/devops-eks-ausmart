variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "common_tags" {
  type = map(string)
}

variable "private_data_subnet_ids" {
  description = "Private data subnet IDs for RDS subnet group"
  type        = list(string)
}

variable "mysql_security_group_id" {
  type = string
}

variable "postgres_security_group_id" {
  type = string
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 100
}

variable "enable_multi_az" {
  description = "Multi-AZ deployment - doubles cost"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  type    = number
  default = 7
}

variable "deletion_protection" {
  description = "Disable before terraform destroy"
  type        = bool
  default     = false
}

variable "enable_kms" {
  type    = bool
  default = false
}

variable "kms_key_arn" {
  type    = string
  default = ""
}

variable "secrets_recovery_window" {
  description = "Days before secret is permanently deleted - 0 for dev"
  type        = number
  default     = 0
}
