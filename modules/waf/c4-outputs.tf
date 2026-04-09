output "web_acl_arn" {
  description = "WAF WebACL ARN — attach to ALB via Ingress annotation"
  value       = aws_wafv2_web_acl.main.arn
}
