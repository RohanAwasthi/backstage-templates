module "resource_group" {
  source                = "../../../modules/terraform-azurerm-resource-group"
  create_resource_group = var.create_resource_group
  name                  = var.resource_group_name
  location              = var.location
  tags                  = var.tags
}

module "vnet" {
  source              = "../../../modules/terraform-azurerm-virtual-network/virtual-network-foreach"
  location            = var.create_resource_group ? module.resource_group.location : var.location
  resource_group_name = var.create_resource_group ? module.resource_group.name : var.resource_group_name
  vnet                = var.vnet
}
