variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "app_service_plan_sku_name" {
  description = "App Service Plan SKU tier"
  type        = string
}



variable "web_app_name" {
  description = "Name of the Azure Web App"
  type        = string
}

variable "aad_client_id" {
  description = "Azure AD App Registration (Application) Client ID"
  type        = string
}
variable "tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
}