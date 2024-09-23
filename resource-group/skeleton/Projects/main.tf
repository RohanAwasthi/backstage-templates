#Reference to resource group creation module
module "resource_group" {
  source                = "./modules/"
  create_resource_group = var.create_resource_group
  name                  = var.resource_group_name
  location              = var.location
  tags                  = var.tags

}
