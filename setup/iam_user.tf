# Create a user for the domain manager
resource "aws_iam_user" "domain_manager" {
  name = "sre_domain_manager"
  path = "/system/"
}

# Create an access key for the domain manager
resource "aws_iam_access_key" "domain_manager" {
  user = aws_iam_user.domain_manager.name
}

# Let the domain manager manage hosted zones
resource "aws_iam_user_policy" "domain_manager" {
  name = "domain_manager"
  user = aws_iam_user.domain_manager.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
        "Effect": "Allow",
        "Action": [
           "route53:CreateHostedZone",
           "route53:ListHostedZones",
           "route53:GetHostedZone",
           "route53:GetChange",
           "route53:ListTagsForResource",
           "route53:DeleteHostedZone",
           "route53:ChangeResourceRecordSets",
           "route53:ListResourceRecordSets"
        ],
        "Resource":"*"
     }
  ]
}
EOF

 ### Policy notes
 ## route53:GetHostedZone, route53:GetChange, route53:ListTagsForResource can be reduced to a limited set of zones
}
