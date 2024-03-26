
data "azurerm_subnet" "subnet" {
  count = var.create_subnet ? 0 : 1
  name                 = var.subnets.keys[0]
  virtual_network_name = var.subnets.keys[0].virtual_network_name
  resource_group_name  = module.resource_group.name
}

data "azurerm_public_ip" "pip" {
  count               = var.create_public_ip ? 0 : 1
  name                = var.public_ip_name 
  resource_group_name = module.resource_group.name
}
