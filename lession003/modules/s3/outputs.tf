output "main_user_access_key_id" {
  value       = aws_iam_access_key.main_user_access_key.id
  description = "main_user_access_key_id"
}

output "main_user_access_secret_key_secret" {
  value       = aws_iam_access_key.main_user_access_key.secret
  description = "main_user_access_key_secret"
  sensitive   = true
}
