variable "name_prefix"  { type = string }
variable "common_tags"  { type = map(string) }

variable "rate_limit" {
  description = "Max requests per 5 min per IP"
  type        = number
  default     = 100
}
