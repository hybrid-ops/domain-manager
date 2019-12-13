variable "root_zone_id" { }

variable "name" { }

variable "name_servers" { }

# Create the zone NS Records
resource "aws_route53_record" "z" {
  name = var.name
  type = "NS"
  ttl = 3600 # 1 hour ttl for these entries
  zone_id = var.root_zone_id
  records = var.name_servers
}

output "fqdn" {
  value = aws_route53_record.z.fqdn
}
