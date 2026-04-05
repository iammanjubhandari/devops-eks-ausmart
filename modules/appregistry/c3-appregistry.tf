# AppRegistry groups all resources under one application in Cost Explorer
# This module is called FIRST - its tag feeds into common_tags for everything else
# Cost: $0 (free service)

resource "aws_servicecatalogappregistry_application" "main" {
  name        = var.name_prefix
  description = var.description

  tags = merge(var.common_tags, {
    Name = var.name_prefix
  })
}

# Attribute group - metadata about the app (who owns it, what repo, etc)
resource "aws_servicecatalogappregistry_attribute_group" "main" {
  name        = "${var.name_prefix}-attributes"
  description = "Metadata for ${var.name_prefix} application"

  attributes = jsonencode({
    project     = var.project_name
    environment = var.environment
    owner       = var.owner
    managed_by  = "terraform"
    repository  = var.repository
  })

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-attributes"
  })
}

# Link attribute group to the application
resource "aws_servicecatalogappregistry_attribute_group_association" "main" {
  application_id     = aws_servicecatalogappregistry_application.main.id
  attribute_group_id = aws_servicecatalogappregistry_attribute_group.main.id
}
