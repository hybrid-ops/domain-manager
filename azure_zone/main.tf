variable "name" { }

variable "resource_group" {
  default = "sre-domain-manager"
}

resource "azurerm_dns_zone" "z" {
  name                = var.name
  resource_group_name = var.resource_group
}

output "name_servers" {
  value = azurerm_dns_zone.z.name_servers
}

output "zone_id" {
  value = azurerm_dns_zone.z.id
}
