resource "azurerm_linux_web_app" "webapp" {
  name                = var.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true
    linux_fx_version = "DOCKER|${var.acr_name}.azurecr.io/mywebapp:${var.image_tag}"
  }

  identity {
    type = "SystemAssigned"
  }
}
