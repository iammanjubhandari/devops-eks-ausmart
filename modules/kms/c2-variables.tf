variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "enable_kms" {
  description = "Create CMKs - off for dev to save ~$3/mo, on for prod"
  type        = bool
  default     = false
}

variable "deletion_window_in_days" {
  description = "Days before key is permanently deleted (safety net)"
  type        = number
  default     = 7
}
