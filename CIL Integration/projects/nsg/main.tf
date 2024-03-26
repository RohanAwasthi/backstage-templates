#Reference to resource group creation module
module "resource_group" {
  source                = "../../modules/terraform-azure-resource-group"
  create_resource_group = var.create_resource_group
  name                  = var.resource_group_name
  location              = var.location
  tags                  = var.tags
}

module "network_security_group" {
  source                = "../../modules/terraform-azure-nsg"
  location              = module.resource_group.location
  resource_group_name   = module.resource_group.name
  csv_file_name_for_NSG = "nsg_rules.csv"
  tags                  = var.tags
}
