terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
}

locals {
  services = [
    "frontend", "adservice", "cartservice", "checkoutservice", 
    "currencyservice", "emailservice", "loadgenerator", 
    "paymentservice", "productcatalogservice", "recommendationservice", "shippingservice"
  ]
}

resource "aws_ecr_repository" "repo" {
  for_each             = toset(local.services)
  name                 = "online-boutique/${each.value}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "cleanup" {
  for_each   = aws_ecr_repository.repo
  repository = each.value.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 3 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 3
      }
      action = {
        type = "expire"
      }
    }]
  })
}

output "repository_urls" {
  value = { for k, v in aws_ecr_repository.repo : k => v.repository_url }
}