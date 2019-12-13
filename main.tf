# The root domain goes here
variable "basedomain" { }


provider "aws" { }

provider "azurerm" { }


module "rootzone" {
  source = "./root_zone_aws"
  basedomain = var.basedomain
}

module "testsubdomain1" {
  source       = "./aws_zone"
  name         = "testzone1.${var.basedomain}"
}

module "testsubdomain1ns" {
  source       = "./aws_zone_ns"
  name         = "testzone1.${var.basedomain}"
  root_zone_id = module.rootzone.zone_id
  name_servers = module.testsubdomain1.name_servers
}

module "azurezone" {
  source       = "./azure_zone"
  name         = "az.${var.basedomain}"
}

module "azurezonens" {
  source       = "./aws_zone_ns"
  name         = "az.${var.basedomain}"
  root_zone_id = module.rootzone.zone_id
  name_servers = module.azurezone.name_servers
}

output "available_zones" {
  value = [
    module.testsubdomain1ns.fqdn,
    module.azurezonens.fqdn
  ]
}
