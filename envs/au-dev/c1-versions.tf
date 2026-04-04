terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "ausmart-terraform-state-dev"
    key            = "envs/au-dev/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "ausmart-terraform-locks-dev"
  }
}

provider "aws" {
  region = var.aws_region
}
