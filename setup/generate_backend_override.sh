#!/usr/bin/env bash

BACKEND_BUCKET=$(terraform output STATE_S3_BUCKET)
BACKEND_KEY=$(terraform output STATE_PATH)


cat <<EOF > ../backend_override.tf

terraform {
  backend "s3" {
    bucket = "${BACKEND_BUCKET}"
    key    = "${BACKEND_KEY}"
    region = "${AWS_REGION}"
  }
}
EOF
