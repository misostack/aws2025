terraform {
  required_version = ">= 1.11" // Replace with the version if needed
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.90" // replace with latest version if needed
    }
  }
}
provider "aws" {
  region  = "us-east-1"
  profile = "jsbase"
}

terraform {
  backend "local" {
    path = "./jsbase.tfstate"
  }
}

# ecr

resource "aws_ecr_repository" "repository" {
  name                 = "jsbase"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}