output "application_id" {
  description = "AppRegistry application ID"
  value       = aws_servicecatalogappregistry_application.main.id
}

output "application_arn" {
  description = "AppRegistry application ARN"
  value       = aws_servicecatalogappregistry_application.main.arn
}

# this is the important one - merge into common_tags so Cost Explorer
# groups all resources under this application automatically
output "application_tag" {
  description = "Tag map for Cost Explorer grouping"
  value       = aws_servicecatalogappregistry_application.main.application_tag
}
