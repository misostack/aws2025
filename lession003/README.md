# Lession 003 - AWS S3

## Examples

```sh
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars" --auto-approve
terraform output -raw main_user_access_secret_key_secret
aws s3 cp ./website/ s3://jsbase-spa/ --recursive --profile jsbase
terraform destroy -var-file="dev.tfvars"
aws s3 rm s3://jsbase-spa --recursive --profile jsbase
```

## Usecases

1. [x] S3 bucket for file storage
2. [x] S3 for spa
3. [ ] S3 with cloudfront for static files
4. [ ] S3 with cloudfront for spa

## References

- [S3] https://docs.aws.amazon.com/AmazonS3/latest/userguide/VirtualHosting.html
