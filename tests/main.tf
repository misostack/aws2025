provider "aws" {
  region  = "us-east-1"
  profile = "jsbase"
}

terraform {
  backend "local" {
    path = "./jsbase.tfstate"
  }
}

module "s3" {
  source = "../lession003/modules/s3-only"

  bucket_name = "jsbase-s3-only"
  tags = {
    Name = "jsbase-s3-only"
  }
}