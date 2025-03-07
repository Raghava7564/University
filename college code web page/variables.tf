# Variables
variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "myResourceGroup"
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "East US"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "myuniqueregistry"
}

variable "acr_sku" {
  description = "SKU tier for the Azure Container Registry"
  type        = string
  default     = "Basic"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "myAppServicePlan"
}

variable "web_app_name" {
  description = "Name of the Web App"
  type        = string
  default     = "myWebApp"
}

variable "app_service_sku" {
  description = "SKU tier for the App Service Plan"
  type        = string
  default     = "P1v2"
}

variable "image_tag" {
  description = "Tag of the Docker image"
  type        = string
  default     = "latest"
}
