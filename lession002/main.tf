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

# terraform {
#   backend "s3" {
#     bucket  = "jsbase-terraform-lession002"
#     key     = "jsbase-terraform-lession002/backend/backend.tf"
#     region  = "us-east-1"
#     encrypt = true
#   }
# }

terraform {
  backend "local" {
    path = "./jsbase-terraform-lession002-backend.tfstate"
  }
}

resource "aws_vpc" "jsbase_main_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "jsbase_main"
  }
}

resource "aws_subnet" "jsbase_main_subnet" {
  vpc_id     = aws_vpc.jsbase_main_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "jsbase_main"
  }
}

resource "aws_internet_gateway" "jsbase_main_igw" {
  vpc_id = aws_vpc.jsbase_main_vpc.id

  tags = {
    Name = "jsbase_main"
  }
}

resource "aws_route_table" "jsbase_main_route_table" {
  vpc_id = aws_vpc.jsbase_main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jsbase_main_igw.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "jsbase_main"
  }
}

resource "aws_main_route_table_association" "jsbase_main_route_table_association" {
  vpc_id         = aws_vpc.jsbase_main_vpc.id
  route_table_id = aws_route_table.jsbase_main_route_table.id
}
