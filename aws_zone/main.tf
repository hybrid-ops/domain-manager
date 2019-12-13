variable "name" { }

variable "comment" {
  default = "Managed by SRE Domain Manager"
}
# Create the hosted zone
resource "aws_route53_zone" "z" {
    name    = var.name
    comment = var.comment
}

output "zone_id" { 
  value = aws_route53_zone.z.zone_id 
}

output "name_servers" {
  value = aws_route53_zone.z.name_servers
}
