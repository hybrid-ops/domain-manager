provider "aws" { }


# Output the details
output "AWS_ACCESS_KEY_ID" {
  value = aws_iam_access_key.domain_manager.id
}

output "AWS_SECRET_ACCESS_KEY" {
  value = aws_iam_access_key.domain_manager.secret
}

output "STATE_S3_BUCKET" {
  value = aws_s3_bucket.domain_manager.bucket_domain_name
}

output "STATE_PATH" {
  value = "var.statefile_path"
}
