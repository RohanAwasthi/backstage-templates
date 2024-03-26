module "resource_group" {
  source                = "../../modules/terraform-azurerm-resource-group"
  create_resource_group = var.create_resource_group
  name                  = var.resource_group_name
  location              = var.location
  tags                  = var.tags
}

module "vnet" {
  count               = var.create_virtual_network ? 1 : 0
  source              = "../../modules/terraform-azurerm-virtual-network/virtual-network-foreach"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet                = var.vnet
}

module "subnet" {
  source              = "../../modules/terraform-azurerm-subnet/subnet-foreach"
  count = var.create_subnet ? 1 : 0
  depends_on          = [module.vnet]
  resource_group_name = module.resource_group.name
  subnets             = var.subnets
}

module "pip" {
  count                   = var.create_public_ip ? 1 : 0
  source                  = "../../modules/terraform-azurerm-public-ip"
  resource_group_name     = module.resource_group.name
  location                = module.resource_group.location
  public_ip_name          = var.public_ip_name
  allocation_method       = var.allocation_method
  sku                     = var.pip_sku
  ip_version              = var.ip_version
  domain_name_label       = var.domain_name_label
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  zones                   = var.zones
  reverse_fqdn            = var.reverse_fqdn
  public_ip_prefix_id     = var.public_ip_prefix_id
  edge_zone               = var.edge_zone
  sku_tier                = var.sku_tier
  ip_tags                 = var.ip_tags
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id
  tags                    = var.tags
}

module "azure-bastion" {
  source                 = "../../modules/terraform-azurerm-bastion-host"
  name                   = var.name
  resource_group_name    = module.resource_group.name
  location               = module.resource_group.location
  copy_paste_enabled     = var.copy_paste_enabled
  file_copy_enabled      = var.file_copy_enabled
  sku                    = var.sku
  ip_connect_enabled     = var.ip_connect_enabled
  scale_units            = var.scale_units
  shareable_link_enabled = var.shareable_link_enabled
  tunneling_enabled      = var.tunneling_enabled
  tags                   = var.tags
  ip_name                = var.ip_name
  subnet_id              = var.create_subnet ? module.subnet[0].subnet_id[0] : data.azurerm_subnet.subnet.0.id
  public_ip_address_id   = var.create_public_ip ? module.pip.0.id : data.azurerm_public_ip.pip.0.id
}