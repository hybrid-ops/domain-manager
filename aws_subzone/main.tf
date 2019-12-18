variable "name" { }

variable "comment" {
  default = "Managed by SRE Domain Manager"
}

variable "parent_zone" { }

variable "parent_fqdn" { }

variable "tags" {
  type    = map
  default = { }
}

# Create the hosted zone
resource "aws_route53_zone" "z" {
    name    = "${var.name}.${var.parent_fqdn}"
    comment = var.comment
    tags    = var.tags
}

# Create the zone NS Records in the parent zone
resource "aws_route53_record" "zns" {
  name = "${var.name}.${var.parent_fqdn}"
  type = "NS"
  ttl = 3600 # 1 hour ttl for these entries
  zone_id = var.parent_zone
  records = aws_route53_zone.z.name_servers
}

output "fqdn" {
  value = aws_route53_record.zns.fqdn
}

output "zone_id" { 
  value = aws_route53_zone.z.zone_id 
}

output "name_servers" {
  value = aws_route53_zone.z.name_servers
}
