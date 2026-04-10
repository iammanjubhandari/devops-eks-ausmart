variable "name_prefix"             { type = string }
variable "common_tags"             { type = map(string) }
variable "private_data_subnet_ids" { type = list(string) }
variable "security_group_id"       { type = string }

variable "node_type" {
  type    = string
  default = "cache.t3.micro"
}

variable "num_cache_nodes" {
  description = "1 for dev, 2+ for prod"
  type        = number
  default     = 1
}

variable "enable_encryption_at_rest" {
  type    = bool
  default = false
}

variable "enable_encryption_in_transit" {
  description = "TLS"
  type        = bool
  default     = false
}
