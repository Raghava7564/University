# Variables
variable "resource_group_name" {
  default = "myResourceGroup"
}

variable "location" {
  default = "East US"
}

variable "acr_name" {
  default = "myacr"
}

variable "acr_sku" {
  default = "Basic"
}

variable "app_service_plan_name" {
  default = "myAppServicePlan"
}

variable "web_app_name" {
  default = "myWebApp"
}

variable "app_service_sku" {
  default = "P1v2"  # Premium for better performance
}
variable "image_tag" {
  description = "Docker image tag from GitHub Actions"
  type        = string
}

