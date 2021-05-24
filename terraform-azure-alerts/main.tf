data "azurerm_resource_group" "myrg" {
    name = "1-bb73f59b-playground-sandbox"
}

resource "azurerm_app_service_plan" "myappplan" {
  name                = "appserviceplan-1"
  location            = data.azurerm_resource_group.myrg.location
  resource_group_name = data.azurerm_resource_group.myrg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "myapp" {
  name                = "terraform-prac1-app-service"
  location            = data.azurerm_resource_group.myrg.location
  resource_group_name = data.azurerm_resource_group.myrg.name
  app_service_plan_id = azurerm_app_service_plan.myappplan.id
}

resource "azurerm_monitor_action_group" "myag" {
  name                = "CriticalAlertsAction"
  resource_group_name = data.azurerm_resource_group.myrg.name
  short_name          = "p0action"
  email_receiver {
    name                    = "sendtodevops"
    email_address           = "devops@contoso.com"
    use_common_alert_schema = true
  }
}

module "appservice-alerts-http4xx" {
  # change source as per folder structure  
  source              = "./modules/alerts"
  name                = "example-metricalert"
  resource_group_name = data.azurerm_resource_group.myrg.name
  scopes              = [azurerm_app_service.myapp.id]
  description         = "Action will be triggered when HTTP 4xx error spike."

  metric_namespace  = "Microsoft.web/sites"
  metric_name       = "Http4xx"
  aggregation       = "Total"
  operator          = "GreaterThan"
  alert_sensitivity = "Medium"
  action_group_id   = azurerm_monitor_action_group.myag.id
}
