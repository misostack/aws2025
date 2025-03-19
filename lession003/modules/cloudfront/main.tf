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

locals {
  s3_origin_id = "cdn"
}


module "s3" {
  source = "../s3-only"

  bucket_name = "jsbase-cloudfront-sample"
  tags = {
    Name = "jsbase"
  }
}


data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "cloudfront_policy" {
  bucket = module.s3.bucket_id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Principal = { "Service": "cloudfront.amazonaws.com" }
      Action   = "s3:GetObject"
      Resource = "arn:aws:s3:::${module.s3.bucket_id}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.this.id}"
        }
      }
    }]
  })
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "CloudFront-OAC"
  description                       = "CloudFront Origin Access Control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
    origin {
        domain_name = module.s3.bucket_regional_domain_name
        origin_id   = local.s3_origin_id
        origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    }
    
    enabled             = true
    is_ipv6_enabled     = true
    comment             = "CDN for S3 bucket"
    default_root_object = "index.html"
    # no need to wait for the deployment to finish
    wait_for_deployment = false
    
    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = local.s3_origin_id
    
        forwarded_values {
        query_string = false
    
        cookies {
            forward = "none"
        }
        }
    
        viewer_protocol_policy = "allow-all"
    }
    
    restrictions {
        geo_restriction {
        restriction_type = "none"
        }
    }
    
    viewer_certificate {
        cloudfront_default_certificate = true
    }
    
    tags = {
        Name = "jsbase-cloudfront"
    }
}