//terraform {
  //required_providers {
    //azurerm = {
      //source = "hashicorp/azurerm"
     // # Root module should specify the maximum provider version
      //# The ~> operator is a convenient shorthand for allowing only patch releases within a specific minor release.
      //version = "~> 2.26"
    //}
  //}
//}

//provider "azurerm" {
  //features {}
//}

resource "azurerm_resource_group" "resource_group" {
  name = "${var.project}-${var.environment}-resource-group"
  location = var.location
}

resource "azurerm_storage_account" "storage_account" {
  name = "${var.project}${var.environment}storage"
  resource_group_name = azurerm_resource_group.resource_group.name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_application_insights" "application_insights" {
  name                = "${var.project}-${var.environment}-application-insights"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  application_type    = "Node.JS"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "${var.project}-${var.environment}-app-service-plan"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  kind                = "FunctionApp"
  reserved = true
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}


# Start
data "archive_file" "file_function_app" {
  type        = "zip"
  source_dir  = "../hello-world"
  output_path = "function-app.zip"
}

resource "azurerm_storage_blob" "storage_blob" {
  # name = "${filesha256(var.archive_file.output_path)}.zip"
  name = "${filesha256("function-app.zip")}.zip"
  storage_account_name = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type = "Block"
  # source = var.archive_file.output_path
  source = "function-app.zip"
}

data "azurerm_storage_account_blob_container_sas" "storage_account_blob_container_sas" {
  connection_string = azurerm_storage_account.storage_account.primary_connection_string
  container_name    = azurerm_storage_container.storage_container.name

  start = "2021-01-01T00:00:00Z"
  expiry = "2022-01-01T00:00:00Z"

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = false
  }
}
resource "azurerm_storage_container" "storage_container" {
    name = "${var.project}-storage-container-functions"
    storage_account_name = azurerm_storage_account.storage_account.name
    container_access_type = "private"
}


# End

resource "azurerm_function_app" "function_app" {
  name                       = "${var.project}-${var.environment}-function-app"
  resource_group_name        = azurerm_resource_group.resource_group.name
  location                   = var.location
  app_service_plan_id        = azurerm_app_service_plan.app_service_plan.id
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"       = "https://${azurerm_storage_account.storage_account.name}.blob.core.windows.net/${azurerm_storage_container.storage_container.name}/${azurerm_storage_blob.storage_blob.name}${data.azurerm_storage_account_blob_container_sas.storage_account_blob_container_sas.sas}",
    "FUNCTIONS_WORKER_RUNTIME" = "node",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key,
  }
  os_type = "linux"
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  version                    = "~3"

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}


# locals {
#     publish_code_command = "az webapp deployment source config-zip --resource-group ${azurerm_resource_group.resource_group.name} --name ${azurerm_function_app.function_app.name} --src ${var.archive_file.output_path}"
# }

# resource "null_resource" "function_app_publish" {
#   provisioner "local-exec" {
#     command = local.publish_code_command
#   }
#   depends_on = [local.publish_code_command]
#   triggers = {
#     input_json = filemd5(var.archive_file.output_path)
#     publish_code_command = local.publish_code_command
#   }
# }
