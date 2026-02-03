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

resource "azurerm_service_plan" "plan" {
  name                   = var.app_service_plan_name
  location               = azurerm_resource_group.rg.location
  resource_group_name    = azurerm_resource_group.rg.name
  os_type                = "Windows"
  sku_name               = "${var.app_service_plan_sku_tier}${var.app_service_plan_sku_size}"
  worker_count           = 2
  zone_balancing_enabled = true
}

resource "azurerm_windows_web_app" "app" {
  name                = var.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  https_only                    = true
  public_network_access_enabled = false
  client_certificate_enabled    = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    ftps_state                        = "Disabled"
    health_check_path                 = "/health"
    health_check_eviction_time_in_min = 10
    http2_enabled                     = true
    always_on                         = true
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "true"
  }

  auth_settings_v2 {
    auth_enabled     = true
    default_provider = "azureactivedirectory_v2"

    active_directory_v2 {
      client_id            = var.aad_client_id
      tenant_auth_endpoint = "https://login.microsoftonline.com/${var.tenant_id}/v2.0"
    }

    login {
      token_store_enabled = true
    }
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

