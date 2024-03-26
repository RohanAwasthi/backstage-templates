<!-- BEGIN_TF_DOCS -->
###### Last Updated[DD/MM/YYYY]: 22/02/2024
##  Introduction 

Analyze logs and metrics with diagnostics settings

## Pre Requisite

One or all of the following resources:
1. Storage account
2. Log Analytics workspace
3. Event Hub
4. Partner Solution (using Azure Native ISV Services)

5. Target Resource (Example :  Azure SQL Database deployed under an SQL Server)

## Requirements

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.87.0 |


## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_categories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diagnostic_setting_name"></a> [diagnostic\_setting\_name](#input\_diagnostic\_setting\_name) | Specifies the name of the Diagnostic Setting. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_excluded_log_categories"></a> [excluded\_log\_categories](#input\_excluded\_log\_categories) | List of log categories to exclude. | `list(string)` | `[]` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table. | `string` | `null` | no |
| <a name="input_log_categories"></a> [log\_categories](#input\_log\_categories) | List of log categories. Defaults to all available. | `list(string)` | `null` | no |
| <a name="input_logs_destinations_ids"></a> [logs\_destinations\_ids](#input\_logs\_destinations\_ids) | List of destination resources IDs for logs diagnostic destination.<br>  Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>  If you want to use Azure EventHub as destination, you must provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| <a name="input_metric_categories"></a> [metric\_categories](#input\_metric\_categories) | List of metric categories. Defaults to all available. | `list(string)` | `null` | no |
| <a name="input_partner_solution_id"></a> [partner\_solution\_id](#input\_partner\_solution\_id) | The ID of the market partner solution where Diagnostics Data should be sent. | `string` | `null` | no |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | ID of the target resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_diag_id"></a> [diag\_id](#output\_diag\_id) | ID of the diagnostic settings resource |

## Module Usage

* The Azure Diagnostics Settings module can be referenced with all possible arguments as follows:

```
module "diagnostic_settings" {
  source                         = "../../modules/terraform-azurerm-diagnostics-settings"
  target_resource_id             = var.target_resource_id
  diagnostic_setting_name        = var.diagnostic_setting_name
  log_analytics_destination_type = var.log_analytics_destination_type
  partner_solution_id            = var.partner_solution_id
  logs_destinations_ids          = var.logs_destinations_ids
}
```

Here the variable ```logs_destinations_ids``` accepts a list of string as input. The list can contain the resource IDs of Storage Account, Log Analytics Workspace and Event Hub. No more than one of each type is accepted.

* When the value of the list ```logs_destinations_ids = ["/subscriptions/your-subscription/resourceGroups/example-resource-group/providers/Microsoft.Storage/storageAccounts/storage-account-id"]```

Diagnostic Settings will be configured to collect all types of Logs and archive it to a storage account.


* When the value of the list ```logs_destinations_ids = ["/subscriptions/your-subscription/resourceGroups/example-resource-group/providers/Microsoft.OperationalInsights/workspaces/workspace-id"]```

Diagnostic Settings will be configured to send all types of logs to a log analytics workspace.

* When the value of the list ```logs_destinations_ids=[""/subscriptions/your-subscription/resourceGroups/example-resource-group/providers/Microsoft.EventHub/namespaces/example-namespace/authorizationRules/myAuthRule|myEventHub"]```

Diagnostic Settings will be configured to stream all types of logs to an Event Hub

* The Azure Diagnostics Settings module can be referenced with only the required arguments as follows:

```
module "diagnostic_settings" {
  source                         = "../../modules/terraform-azurerm-diagnostics-settings"
  target_resource_id             = var.target_resource_id
  diagnostic_setting_name        = var.diagnostic_setting_name
  logs_destinations_ids          = var.logs_destinations_ids
}
```

<!-- END_TF_DOCS -->