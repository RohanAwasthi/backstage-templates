variable "diagnostic_setting_name" {
  description = "Specifies the name of the Diagnostic Setting. Changing this forces a new resource to be created."  
  type        = string
}

variable "target_resource_id" {
  description = "The ID of an existing Resource on which to configure Diagnostic Settings. Changing this forces a new resource to be created."
  type        = string 
}

variable "log_categories" {
  description = "List of log categories. Defaults to all available."
  type        = list(string)
  default     = null  
}

variable "excluded_log_categories" {
  description = "List of log categories to exclude."
  type        = list(string)
  default     = []
}

variable "metric_categories" {
  description = "List of metric categories. Defaults to all available."
  type        = list(string)
  default     = null
}

variable "logs_destinations_ids" {
  description = <<EOF
  List of destination resources IDs for logs diagnostic destination.
  Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.
  If you want to use Azure EventHub as destination, you must provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character.
  EOF
  type        = list(string)
  nullable    = false
}

variable "log_analytics_destination_type" {
  description = "When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
  type        = string
  default     = null
}

variable "partner_solution_id" {
  description = "The ID of the market partner solution where Diagnostics Data should be sent."
  type        = string
  default     = null
}
