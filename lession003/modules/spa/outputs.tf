output "domain_name" {
  value = aws_s3_bucket.main_s3_bucket.website_endpoint
}

