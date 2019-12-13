# What's this?

Just a simple terraform to create the users and structure to prepare for gitops managed domain structure.
The scripts/terraforms needs to be run with elevated access as it is required to create users. These new users are used by the automation to perform the neccessary domain management.

The Route53 policy is fairly minimalistic, but most of the actions can be limited to specific resources for even tighter control.


## Notes

#### AzureAD service principal
The service principal password will expire after a set time, so this terraform has to be rerun to get a new password
