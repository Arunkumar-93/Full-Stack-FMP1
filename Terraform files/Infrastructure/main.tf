provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "feedback-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "feedback-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "frontend" {
  name                = "feedback-frontend-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

   app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITES_PORT"                       = "3000"
    "NODE_ENV"                            = "production"
  }

  site_config {
    linux_fx_version = "DOCKER|node:18"
  }
}

resource "azurerm_app_service" "backend" {
  name                = "feedback-backend-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    python_version = "3.10"
  }

  app_settings = {
    "DJANGO_SETTINGS_MODULE" = "feedback_backend.settings"
    "WEBSITES_PORT"          = "8000"
  }
}

resource "azurerm_key_vault" "kv" {
  name                        = "feedback-keyvault"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "get", "list", "set", "delete"
    ]
  }
}

data "azurerm_client_config" "current" {}



