variable "name" { }

variable "resource_group" {
  default = "sre-domain-manager"
}

variable "parent_zone" { }

variable "parent_fqdn" { }

variable "tags" {
  type    = map
  default = { }
}

resource "azurerm_dns_zone" "z" {
  name                = "${var.name}.${var.parent_fqdn}"
  resource_group_name = var.resource_group
  tags                = var.tags
}

resource "azurerm_dns_ns_record" "zns" {
  name                = var.name
  zone_name           = var.parent_zone
  resource_group_name = var.resource_group
  ttl                 = 3600

  records = azurerm_dns_zone.z.name_servers 

  tags = var.tags
}

output "name_servers" {
  value = azurerm_dns_zone.z.name_servers
}

output "zone_id" {
  value = azurerm_dns_zone.z.name
}

output "fqdn" {
  value = azurerm_dns_ns_record.zns.fqdn
}
