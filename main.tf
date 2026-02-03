terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

}

resource "azurerm_app_service_plan" "plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = var.app_service_plan_sku_tier
    size = var.app_service_plan_sku_size
  }
}

resource "azurerm_windows_web_app" "app" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_app_service_plan.plan.id

  https_only                    = true
  public_network_access_enabled = false

  identity {
    type = "SystemAssigned"
  }

  site_config {
    ftps_state        = "Disabled"
    health_check_path = "/health"
    http2_enabled     = true
  }

  logs {
    detailed_error_messages = true
    failed_request_tracing  = true

    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }
}

