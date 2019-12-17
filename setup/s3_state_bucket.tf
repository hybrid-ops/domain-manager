variable "statefile_path" {
  default = "domain_manager/terraform.tfstate"
}

# https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
# Create a bucket for remote terraform state for the domain manager
resource "aws_s3_bucket" "domain_manager" {
  bucket = "sre-domain-manager-state"
  acl    = "private"
  
  
  versioning {
    enabled = true
  }

  tags = merge(var.default_tags, {
    Name        = "SRE Domain Manager State"
    Environment = "Production"
  })
}

# https://www.terraform.io/docs/providers/aws/r/s3_bucket_policy.html
# Give the domain manager access to the bucket
resource "aws_s3_bucket_policy" "domain_manager_s3_policy" {
  depends_on = [ aws_s3_bucket.domain_manager ]
  bucket = aws_s3_bucket.domain_manager.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "domain_manager_s3_access",
  "Statement": [
     {
       "Sid": "domain_manager-list-statebucket",
       "Action": "s3:ListBucket",
       "Effect": "Allow",
       "Resource": ["${aws_s3_bucket.domain_manager.arn}",
                    "${aws_s3_bucket.domain_manager.arn}/*"],
       "Principal": {
         "AWS": [
           "${aws_iam_user.domain_manager.arn}"
         ]
       }
     },
     {
       "Sid": "domain_manager-put-statefile",
       "Effect": "Allow",
       "Action": ["s3:GetObject", "s3:PutObject"],
       "Resource": ["${aws_s3_bucket.domain_manager.arn}/${var.statefile_path}"],
       "Principal": {
         "AWS": [
           "${aws_iam_user.domain_manager.arn}"
         ]
       }
     }
 ]
}
POLICY
}
