# Configure the Azure Provider
provider "azurerm" {
  features {}
subscription_id = "d9f05757-f3b3-4460-aa6c-da6ed3898008"
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name  # ✅ Using variable
  location = var.location             # ✅ Using variable
}

# Create Random String for Unique ACR Name
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Create Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}${random_string.suffix.result}"  # ✅ Using variable
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.acr_sku  # ✅ Using variable
  admin_enabled       = true
}

# Create App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name  # ✅ Using variable
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku  # ✅ Using variable
}

# Create Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = "mywebapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      docker_image_name = "${azurerm_container_registry.acr.login_server}/mywebapp"
      docker_image_name  = var.image_tag
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}


# Output ACR Login Server
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
