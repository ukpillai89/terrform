module "azurerm_monitor_metric_alert" "my-alert-1" {
  name                = var.alert_name
  resource_group_name = var.rg_name
  scopes              = var.to_scope
  description         = var.desc

  action {
    action_group_id = var.acg
  }
}