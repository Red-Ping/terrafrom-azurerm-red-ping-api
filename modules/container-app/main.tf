terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.61.0, < 4.0.0"
    }
  }
}


resource "azurerm_container_app_environment" "main" {
  name                = "cae-redpingapi-${var.name_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  log_analytics_workspace_id = var.log_analytics_workspace_id
}

resource "azurerm_container_app" "main" {
  name                = "ca-redpingapi-${var.name_suffix}"
  resource_group_name = var.resource_group_name
  tags                = var.tags

  container_app_environment_id = azurerm_container_app_environment.main.id
  revision_mode                = "Single"

  template {
    container {
      name   = "red-ping-api"
      image  = "ghcr.io/red-ping/red-ping-api:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  identity {
    type = "SystemAssigned"
  }
}