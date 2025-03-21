provider "azurerm" {
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