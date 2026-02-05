output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Resource group created by infra"
}

output "app_service_plan_name" {
  value       = azurerm_service_plan.plan.name
  description = "App Service Plan name"
}

output "web_app_name" {
  value       = azurerm_windows_web_app.app.name
  description = "Azure Web App name"
}

output "web_app_default_hostname" {
  value       = azurerm_windows_web_app.app.default_hostname
  description = "Web App public URL"
}