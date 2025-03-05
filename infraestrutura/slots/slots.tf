provider "azurerm" {
    features {}
    subscription_id = "ac750edc-c180-47c1-b84b-189beb733972"
}

resource "azurerm_resource_group" "rg" {
    name     = "rg-implantacao"
    location = "brazilsouth"
  
}

resource "azurerm_app_service_plan" "plan" {
    name                = "appslots-implantacao"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
  
    sku {
      tier = "Standard"
      size = "S1"
    }
  
}

resource "azurerm_app_service" "appservice" {
  name = "appserviceslotsluiz"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}

resource "azurerm_app_service_slot" "slot" {
  name = "slotluiz"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_name = azurerm_app_service.appservice.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}