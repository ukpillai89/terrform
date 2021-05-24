resource "azurerm_monitor_metric_alert" "my-alert-1" {
  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = var.description
  dynamic_criteria {
    metric_namespace = var.metric_namespace
    metric_name      = var.metric_name
    aggregation      = var.aggregation
    operator         = var.operator
    alert_sensitivity = var.alert_sensitivity
  }
  action {
    action_group_id = var.action_group_id
  }
}
