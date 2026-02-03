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

variable "app_service_plan_sku_tier" {
  description = "App Service Plan SKU tier"
  type        = string
  default     = "Basic"
}

variable "app_service_plan_sku_size" {
  description = "App Service Plan SKU size"
  type        = string
  default     = "B1"
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