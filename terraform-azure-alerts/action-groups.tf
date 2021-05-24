resource "azurerm_monitor_action_group" "myag" {
  name                = var.name
  resource_group_name = var.resource_group_name
  short_name          = var.short_name
  email_receiver {
    name                    = var.addreser_name
    email_address           = var.email_address
    use_common_alert_schema = var.common_alert_schema
  }
}
output "actiongroup-id" {
  value = azurerm_monitor_action_group.myag.id
}
