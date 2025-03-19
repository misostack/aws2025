terraform {
  required_version = ">= 1.11" // Replace with the version if needed
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.90" // replace with latest version if needed
    }
  }
}
