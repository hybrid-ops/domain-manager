# The root domain goes here
variable "basedomain" { }


provider "aws" { }

provider "azurerm" { }


module "rootzone" {
  source = "./root_zone_aws"
  basedomain = var.basedomain
}

## Azure Base Zone
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

## AWS Base Zone
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

## AWS Dev environment zone
module "awsdev" {
  source        = "./aws_subzone"
  name          = "dev"
  parent_fqdn   = module.awsbasens.fqdn
  parent_zone   = module.awsbase.zone_id
}

## Azure Dev environment zone
module "azdev" {
  source        = "./azure_subzone"
  name          = "dev"
  parent_fqdn   = module.azurebasens.fqdn
  parent_zone   = module.azurebase.zone_id
}

## Outputs
output "available_zones" {
  value = [
    module.awsbasens.fqdn,
    module.awsdev.fqdn,
    module.azurebasens.fqdn,
    module.azdev.fqdn
    
  ]
}
