resource "azurerm_resource_group" "rg" {
  name     = "devex-${{ values.component_id }}-rg"
  location = var.location
  tags     = var.tags
}



resource "azurerm_linux_web_app" "web-app" {
  name                = "${{ values.component_id }}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {}
}