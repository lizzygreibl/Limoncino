# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

# This file contains the provider configuration for Terraform Cloud, add it to your existing provider configuretion (dont replace)

terraform {
  cloud {
    organization = "Limoncino-Corp"

    workspaces {
      name = "Limoncino"
    }
  }
}