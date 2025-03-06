# Configure the Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "d9f05757-f3b3-4460-aa6c-da6ed3898008"
}


# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "West Europe"
}

# Create Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "myacrregistry${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}


# Create App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "myAppServicePlan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "F1" # Use F1 for Free, B1 for Basic
}

# Create Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = "myWebApp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      docker_image_name   = "${azurerm_container_registry.acr.login_server}/mywebapp:latest"
      docker_registry_url = "https://${azurerm_container_registry.acr.login_server}"
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    DOCKER_REGISTRY_SERVER_URL          = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME     = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = azurerm_container_registry.acr.admin_password
  }
}


# Output ACR Login Server
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
