output "name" {
  value = aws_cloudfront_distribution.this.id  
}

output "domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "status" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "last_modified_time" {
  value = aws_cloudfront_distribution.this.last_modified_time
}