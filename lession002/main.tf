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

resource "aws_security_group" "jsbase_main_sg" {
  name        = "jsbase_main"
  description = "jsbase_main security group"
  vpc_id      = aws_vpc.jsbase_main_vpc.id
  tags = {
    Name = "jsbase_main"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_vpc_security_group_ingress_rule" "jsbase_main_sg_ingress_ssh_rule" {
  security_group_id = aws_security_group.jsbase_main_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22 # Allows ssh
  to_port     = 22 # Allows ssh
}

resource "aws_vpc_security_group_ingress_rule" "jsbase_main_sg_ingress_icmp_rule" {
  security_group_id = aws_security_group.jsbase_main_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "icmp"
  from_port   = -1 # Allows all ICMP types
  to_port     = -1 # Allows all ICMP codes
}

resource "aws_instance" "jsbase_main_ec2" {
  ami             = "ami-04b4f1a9cf54c11d0"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.jsbase_main_subnet.id
  private_ip      = "10.0.1.4"
  security_groups = [aws_security_group.jsbase_main_sg.id]

  tags = {
    Name = "jsbase_main"
  }
}

resource "aws_eip" "jsbase_main_eip" {
  domain = "vpc"

  instance                  = aws_instance.jsbase_main_ec2.id
  associate_with_private_ip = "10.0.1.4"
  depends_on                = [aws_internet_gateway.jsbase_main_igw]
}

