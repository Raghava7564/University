# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Variables
variable "resource_group_name" {
  default = "myResourceGroup"
}

variable "location" {
  default = "East US"
}

variable "app_service_plan_name" {
  default = "myAppServicePlan"
}

variable "web_app_name" {
  default = "myWebApp"
}

variable "app_service_sku" {
  default = "F1"  # Free Tier
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Free"  # Options: Free, Shared, Basic, Standard, Premium
    size = var.app_service_sku
  }
}

# Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = var.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true

    # Docker container settings (optional)
    # Use this if deploying a containerized app
    # container_registry_use_managed_identity = false
    # linux_fx_version                       = "DOCKER|<container-registry>/<image-name>:<tag>"
  }

  # Optional Application Settings
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    MY_CUSTOM_SETTING                   = "custom_value"
  }

  identity {
    type = "SystemAssigned"  # For Managed Identity
  }
}

# Outputs
output "web_app_url" {
 value = azurerm_linux_web_app.webapp.fqdn

}

    
