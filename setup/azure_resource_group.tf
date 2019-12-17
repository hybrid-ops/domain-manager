## Create the resource group and assign appropriate permissions
variable "resource_group" {
  default = "sre-domain-manager"
}

variable "location" {
  default = "West Europe"
}

resource "azurerm_resource_group" "domain_manager" {
  name      = var.resource_group
  location  = var.location
  tags      = var.default_tags
}


# Assign the relevant permissions to service principal
resource "azurerm_role_assignment" "service_principal" {
  scope                = azurerm_resource_group.domain_manager.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azuread_service_principal.domain_manager.id
}

// resource "azurerm_role_assignment" "service_principal_sub_reader" {
//   scope                = data.azurerm_subscription.current.id
//   role_definition_name = "Reader"
//   principal_id         = azurerm_azuread_service_principal.principal.id
// }
// 
// resource "azurerm_role_assignment" "service_principal_network_joiner" {
//   count                = length(var.subnets)
//   scope                = var.subnets[count.index]
//   role_definition_name = "Network Contributor"
//   principal_id         = azurerm_azuread_service_principal.principal.id
// }
