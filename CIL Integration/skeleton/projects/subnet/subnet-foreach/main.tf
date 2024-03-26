module "resource_group" {
  source                = "../../../modules/terraform-azurerm-resource-group"
  create_resource_group = var.create_resource_group
  name                  = var.resource_group_name
  location              = var.location
  tags                  = var.tags
}

module "vnet" {
  count               = var.create_virtual_network ? 1 : 0
  source              = "../../../modules/terraform-azurerm-virtual-network/virtual-network-foreach"
  location            = var.create_resource_group ? module.resource_group.location : var.location
  resource_group_name = var.create_resource_group ? module.resource_group.name : var.resource_group_name
  vnet                = var.vnet
}

module "subnet" {
  source              = "../../../modules/terraform-azurerm-subnet/subnet-foreach"
  depends_on          = [module.vnet]
  resource_group_name = var.create_resource_group ? module.resource_group.name : var.resource_group_name
  subnets             = var.subnets
}
