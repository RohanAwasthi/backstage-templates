data "azurerm_monitor_diagnostic_categories" "main" {
  resource_id = var.target_resource_id
}
resource "azurerm_monitor_diagnostic_setting" "diag" {
  name                           = var.diagnostic_setting_name
  target_resource_id             = var.target_resource_id
  eventhub_name                  = local.eventhub_name
  eventhub_authorization_rule_id = local.eventhub_authorization_rule_id
  dynamic "enabled_log" {
    for_each = local.log_categories
    content {
      category = enabled_log.value
    }
  }
  dynamic "metric" {
    for_each = local.metrics
    content {
      category = metric.key
      enabled  = metric.value.enabled
    }
  }
  log_analytics_workspace_id     = local.log_analytics_workspace_id
  storage_account_id             = local.storage_account_id
  log_analytics_destination_type = local.log_analytics_destination_type
  partner_solution_id            = var.partner_solution_id
}
