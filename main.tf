terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.61.0, < 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-redpingapi-${var.naming_suffix}"
  location = var.location
  tags     = var.tags
}

module "container" {
  source = "./modules/container-app"

  location                   = var.location
  log_analytics_workspace_id = var.log_analytics_workspace_id
  name_suffix                = var.name_suffix
  resource_group_name        = azurerm_resource_group.main.name
  tags                       = var.tags
}