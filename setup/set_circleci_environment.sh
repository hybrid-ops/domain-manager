#!/usr/bin/env bash
USERNAME="hybrid-ops"
PROJECT="domain-manager"

# The following values must be set externally

# CCI_TOKEN for CircleCI API token
# AWS_REGION
# ARM_TENANT_ID
# ARM_SUBSCRIPTION_ID
# SLACK_WEBHOOK


echo "This script makes a bunch of assumptions, you should read through it to make sure prereqs are met before running."

echo "Getting variable values from terraform"
BACKEND_BUCKET=$(terraform output STATE_S3_BUCKET)
BACKEND_KEY=$(terraform output STATE_PATH)
ARM_CLIENT_ID=$(terraform output ARM_CLIENT_ID)
ARM_CLIENT_SECRET=$(terraform output ARM_CLIENT_SECRET)
AWS_ACCESS_KEY_ID=$(terraform output AWS_ACCESS_KEY_ID)
AWS_SECRET_ACCESS_KEY=$(terraform output AWS_SECRET_ACCESS_KEY)



echo "Setting environment variables in CircleCI"
for k in BACKEND_BUCKET BACKEND_KEY ARM_CLIENT_ID ARM_TENANT_ID ARM_CLIENT_SECRET ARM_SUBSCRIPTION_ID AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION SLACK_WEBHOOK
do
  # Create the CircleCI environment variables
  json='{"name":"'${k}'","value":"'${!k}'"}'
  curl -X POST --header "Content-Type: application/json" -d ${json} "https://circleci.com/api/v1.1/project/github/${USERNAME}/${PROJECT}/envvar?circle-token=$CCI_TOKEN"
done
