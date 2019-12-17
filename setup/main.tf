variable "default_tags" {
  description = "Default tags to apply to all resources that support tagging"
  type        = map
  default     = {}
}

provider "aws" { }

# Output the details
output "AWS_ACCESS_KEY_ID" {
  value = aws_iam_access_key.domain_manager.id
}

output "AWS_SECRET_ACCESS_KEY" {
  value = aws_iam_access_key.domain_manager.secret
}

output "STATE_S3_BUCKET" {
  value = aws_s3_bucket.domain_manager.bucket
}

output "STATE_PATH" {
  value = var.statefile_path
}
