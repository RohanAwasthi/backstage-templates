module "diagnostic_settings" {
  source                         = "../../modules/terraform-azurerm-diagnostics-settings"
  target_resource_id             = var.target_resource_id
  diagnostic_setting_name        = var.diagnostic_setting_name
  log_analytics_destination_type = var.log_analytics_destination_type
  logs_destinations_ids          = var.logs_destinations_ids
  log_categories                 = var.log_categories
  metric_categories              = var.metrics
}
