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
  region = "us-east-1"
  profile = "test"
}
terraform {
  backend "s3" {
    bucket = "jsbase-terraform-lession001"
    key = "jsbase-terraform-lession001/backend/backend.tf"
    region = "us-east-1"
    encrypt = true
  }
}

resource "aws_instance" "JSBaseExample" {
  ami = "ami-04b4f1a9cf54c11d0" // Change it to your preferred AMI. In this case it is Ubuntu 24.x
  instance_type = "t2.micro"

  tags = {
    Name = "JSBaseExample"
  }
}