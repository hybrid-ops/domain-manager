variable "basedomain" { }

// variable "subdomains" { 
//   type = map(map(any))
//   # Example
//  //  subdomains = [
//  //    foobar = {
//  //      name = "foobar"
//  //      nameservers = []
//  //  ]
//  // }
// }

data "aws_route53_zone" "basedomain" {
  name         = "${var.basedomain}."
}

output "zone_id" { 
  value = data.aws_route53_zone.basedomain.zone_id 
}

# Create the zone NS Records
// resource "aws_route53_record" "cluster_zone" {
//   count = length(var.subdomains)
//   name = "${var.cluster_name}.${data.aws_route53_zone.basedomain.name}"
//   type = "NS"
//   ttl = 60 # We should have a short ttl since this is only temporary
//   zone_id = data.aws_route53_zone.basedomain.zone_id
//   records = aws_route53_zone.cluster_zone.name_servers
// }
