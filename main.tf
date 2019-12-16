# The root domain goes here
variable "basedomain" { }


provider "aws" { }

provider "azurerm" { }


module "rootzone" {
  source = "./root_zone_aws"
  basedomain = var.basedomain
}

module "azurebase" {
  source       = "./azure_zone"
  name         = "az.${var.basedomain}"
}

module "azurebasens" {
  source       = "./aws_zone_ns"
  name         = "az.${var.basedomain}"
  root_zone_id = module.rootzone.zone_id
  name_servers = module.azurebase.name_servers
}

module "awsbase" {
  source        = "./aws_zone"
  name          = "aw.${var.basedomain}"
}

module "awsbasens" {
  source       = "./aws_zone_ns"
  name         = "aw.${var.basedomain}"
  root_zone_id = module.rootzone.zone_id
  name_servers = module.awsbase.name_servers  
}

output "available_zones" {
  value = [
    module.awsbasens.fqdn,
    module.azurebasens.fqdn
  ]
}
