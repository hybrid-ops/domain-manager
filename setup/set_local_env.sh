#!/usr/bin/env bash
USERNAME="hybrid-ops"
PROJECT="domain-manager"

# The following values must be set externally

# AWS_REGION
# ARM_TENANT_ID
# ARM_SUBSCRIPTION_ID

echo "This file needs to be sourced"
echo "Setting variable values from terraform"
export BACKEND_BUCKET=$(terraform output STATE_S3_BUCKET)
export BACKEND_KEY=$(terraform output STATE_PATH)
export ARM_CLIENT_ID=$(terraform output ARM_CLIENT_ID)
export ARM_CLIENT_SECRET=$(terraform output ARM_CLIENT_SECRET)
export AWS_ACCESS_KEY_ID=$(terraform output AWS_ACCESS_KEY_ID)
export AWS_SECRET_ACCESS_KEY=$(terraform output AWS_SECRET_ACCESS_KEY)
