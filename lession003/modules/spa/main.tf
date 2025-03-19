provider "aws" {
  region  = var.region
  profile = var.profile
}

terraform {
  backend "local" {
    path = "./jsbase-terraform-lession003-s3-backend.tfstate"
  }
}


resource "aws_s3_bucket" "main_s3_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "jsbase-${var.environment}"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.main_s3_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.main_s3_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "main_s3_bucket_public_access_block" {
  bucket = aws_s3_bucket.main_s3_bucket.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "main_spa" {
  bucket = aws_s3_bucket.main_s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

