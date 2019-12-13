provider "azuread" {
  
}

## Create an application with a service principal and password
resource "random_password" "service_principal" {
  length = 32
  special = true
  override_special = "_-*"
}

resource "azuread_application" "domain_manager" {
  name = "DomainManagerApp"
}

# Create a service principal
resource "azuread_service_principal" "domain_manager" {
  application_id = azuread_application.domain_manager.application_id
}

resource "azuread_service_principal_password" "domain_manager" {
  service_principal_id = azuread_service_principal.domain_manager.id
  value                = random_password.service_principal.result
  end_date_relative    = "2400h"
}

output "service_principal_password" {
  value = "export ARM_CLIENT_SECRET=\"${random_password.service_principal.result}\""
}

output "principal_id" {
  value = "export ARM_CLIENT_ID=\"${azuread_service_principal.domain_manager.application_id}\""
}
